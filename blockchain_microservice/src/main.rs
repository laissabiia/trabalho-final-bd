use actix_web::{web, App, HttpServer, Responder, HttpResponse, get, post};
use chrono::Utc;
use serde::{Deserialize, Serialize};
use sha2::{Sha256, Digest};
use sled::Db;
use std::sync::Mutex;

#[derive(Serialize, Deserialize, Clone)]
struct Bloco {
    id_proposta: String,
    tipo_evento: String,
    hash_documento: String,
    assinatura: String,
    timestamp: String,
    nonce: u64,
    hash_anterior: String,
    hash_bloco: String,
}

#[derive(Deserialize)]
struct RegistroInput {
    id_proposta: String,
    tipo_evento: String,
    hash_documento: String,
    assinatura: String,
}

struct AppState {
    db: Db,
    last_block: Mutex<Option<Bloco>>,
}

#[post("/blockchain/registros")]
async fn novo_registro(data: web::Json<RegistroInput>, db: web::Data<AppState>) -> impl Responder {
    let ultimo_bloco = db.last_block.lock().unwrap().clone();

    let timestamp = Utc::now().to_rfc3339();
    let hash_anterior = ultimo_bloco.map_or(String::new(), |b| b.hash_bloco);

    let mut nonce: u64 = 0;
    let hash_bloco;
    loop {
        let mut hasher = Sha256::new();
        hasher.update(&data.id_proposta);
        hasher.update(&data.tipo_evento);
        hasher.update(&data.hash_documento);
        hasher.update(&data.assinatura);
        hasher.update(&timestamp);
        hasher.update(&hash_anterior);
        hasher.update(nonce.to_be_bytes());
        let resultado = hasher.finalize();
        let tentativa = format!("{:x}", resultado);
        if tentativa.starts_with("0000") {
            hash_bloco = tentativa;
            break;
        }
        nonce += 1;
    }

    let bloco = Bloco {
        id_proposta: data.id_proposta.clone(),
        tipo_evento: data.tipo_evento.clone(),
        hash_documento: data.hash_documento.clone(),
        assinatura: data.assinatura.clone(),
        timestamp,
        nonce,
        hash_anterior,
        hash_bloco: hash_bloco.clone(),
    };

    let _ = db.db.insert(hash_bloco.as_bytes(), bincode::serialize(&bloco).unwrap());
    *db.last_block.lock().unwrap() = Some(bloco.clone());

    HttpResponse::Ok().json(bloco)
}

#[get("/blockchain/historico/{id_proposta}")]
async fn historico(path: web::Path<String>, db: web::Data<AppState>) -> impl Responder {
    let id_proposta = path.into_inner();
    let mut historico: Vec<Bloco> = vec![];

    for result in db.db.iter() {
        if let Ok((_, valor)) = result {
            if let Ok(bloco) = bincode::deserialize::<Bloco>(&valor) {
                if bloco.id_proposta == id_proposta {
                    historico.push(bloco);
                }
            }
        }
    }

    historico.sort_by(|a, b| a.timestamp.cmp(&b.timestamp));
    HttpResponse::Ok().json(historico)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let db = sled::open("blockchain_db").expect("falha ao abrir banco de dados");
    let ultimo = db
        .iter()
        .values()
        .filter_map(Result::ok)
        .filter_map(|v| bincode::deserialize::<Bloco>(&v).ok())
        .max_by_key(|b| b.timestamp.clone());

    let state = web::Data::new(AppState {
        db,
        last_block: Mutex::new(ultimo),
    });

    HttpServer::new(move || {
        App::new()
            .app_data(state.clone())
            .service(novo_registro)
            .service(historico)
    })
    .bind(("localhost", 8080))?
    .run()
    .await
}
