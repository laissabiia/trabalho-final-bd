const PropostaModel = require("../models/propostaModel");
const DocumentoEstagioModel = require("../models/documentoEstagioModel");
const pool = require("../models/db");
const calcularHashArquivoPDF = require("../utils/calcularHashArquivoPDF");
const fetch = require("node-fetch");

const propostaController = {
  async create(req, res) {
    let proposta = null;
    try {
      const id_usuario = req.user.id_usuario;

      const result = await pool.query(
        "SELECT id_estagiario FROM estagiario WHERE id_usuario = $1",
        [id_usuario]
      );
      if (result.rows.length === 0) {
        return res.status(400).json({ error: "Usuário não é estagiário." });
      }
      const id_estagiario = result.rows[0].id_estagiario;

      const { id_escola, id_area, id_modalidade, id_professor, status } =
        req.body;

      const propostaData = {
        id_estagiario,
        id_escola,
        id_area,
        id_modalidade,
        id_professor,
        status: status || "pendente",
      };
      proposta = await PropostaModel.create(propostaData);

      if (!proposta || !proposta.id_proposta) {
        throw new Error("Falha ao criar proposta: id_proposta indefinido.");
      }

      console.log("Proposta criada:", proposta);
      console.log("ID da proposta criada:", proposta.id_proposta); // debug extra
      res.status(201).json({ id_proposta: proposta.id_proposta });
    } catch (error) {
      console.error("Erro ao criar proposta:", error);
      if (!res.headersSent) {
        res.status(400).json({ error: error.message });
      }
    }
  },

  async uploadDocumento(req, res) {
    try {
      const id_proposta = req.params.id_proposta || req.body.id_proposta;
      console.log("Upload recebido para id_proposta:", id_proposta); // debug

      if (!id_proposta || isNaN(parseInt(id_proposta))) {
        return res
          .status(400)
          .json({ error: "ID da proposta inválido ou ausente." });
      }

      const proposta = await PropostaModel.findById(id_proposta);
      if (!proposta) {
        return res.status(404).json({ error: "Proposta não encontrada." });
      }

      if (!req.file || !req.file.path) {
        return res.status(400).json({ error: "Arquivo não enviado." });
      }

      const caminhoPDF = req.file.path;
      const hashDocumento = await calcularHashArquivoPDF(caminhoPDF);

      const doc = await DocumentoEstagioModel.create({
        id_proposta,
        tipo_documento: "proposta",
        caminho_pdf: caminhoPDF,
        hash_documento: hashDocumento,
      });

      const resp = await fetch("http://127.0.0.1:8080/blockchain/registros", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_proposta: parseInt(id_proposta, 10),
          tipo_evento: "upload_documento",
          hash_documento: hashDocumento,
          assinatura: "assinatura_simples",
        }),
      });

      if (!resp.ok) {
        return res
          .status(500)
          .json({ error: "Erro ao registrar no blockchain." });
      }

      const bloco = await resp.json();

      await pool.query(
        `INSERT INTO blockchain_registro
         (id_proposta, id_documento, tipo_evento, hash_blockchain)
         VALUES ($1, $2, $3, $4)`,
        [
          parseInt(id_proposta, 10),
          doc.id_documento,
          bloco.tipo_evento || "upload_documento",
          bloco.hash_bloco,
        ]
      );

      console.log("Documento salvo:", doc);
      console.log("Bloco registrado:", bloco);
      res.status(201).json({ documento: doc, bloco });
    } catch (error) {
      console.error("Erro ao salvar documento:", error);
      res.status(400).json({ error: error.message });
    }
  },

  async findAll(req, res) {
    try {
      const propostas = await PropostaModel.findAll();
      res.json(propostas);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async findById(req, res) {
    try {
      const proposta = await PropostaModel.findById(req.params.id);
      if (!proposta)
        return res.status(404).json({ error: "Proposta não encontrada" });
      res.json(proposta);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async update(req, res) {
    try {
      const payload = req.user; // vem do authMiddleware, contém id_usuario

      // Monte o objeto de criação, sobrescrevendo id_estagiario pelo valor do token:
      const propostaData = {
        id_estagiario: payload.id_usuario, // sempre pega do usuário autenticado
        id_escola: req.body.id_escola,
        id_area: req.body.id_area,
        id_modalidade: req.body.id_modalidade,
        id_professor: req.body.id_professor,
        status: req.body.status || "pendente",
      };

      const proposta = await PropostaModel.create(propostaData);

      if (!proposta)
        return res.status(404).json({ error: "Proposta não encontrada" });
      res.json(proposta);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  },

  async remove(req, res) {
    try {
      await PropostaModel.remove(req.params.id);
      res.json({ message: "Proposta removida com sucesso" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = propostaController;
