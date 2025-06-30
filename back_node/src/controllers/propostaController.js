// src/controllers/propostaController.js
const PropostaModel = require("../models/propostaModel");
const DocumentoEstagioModel = require("../models/documentoEstagioModel");
const pool = require("../models/db");
const calcularHashArquivoPDF = require("../utils/calcularHashArquivoPDF");
const fetch = require("node-fetch").default; // <— Import corrigido
const path = require("path");

const propostaController = {
  async create(req, res) {
    try {
      console.log("[propostaController.create] req.user:", req.user);

      // 1) Extrai ID do usuário do token
      const id_usuario =
        (req.user.id_usuario && parseInt(req.user.id_usuario, 10)) ||
        (req.user.id && parseInt(req.user.id, 10));
      if (!id_usuario) {
        return res.status(401).json({ error: "Usuário não autenticado." });
      }

      // 2) Verifica perfil de estagiário
      const est = await pool.query(
        "SELECT id_estagiario, id_instituicao FROM estagiario WHERE id_usuario = $1",
        [id_usuario]
      );
      if (est.rows.length === 0) {
        return res.status(403).json({ error: "Usuário não é estagiário." });
      }
      const { id_estagiario, id_instituicao } = est.rows[0];

      // 3) Desestrutura e valida campos
      const {
        id_escola,
        id_area,
        id_modalidade,
        id_professor,
        id_orientador,
        status,
      } = req.body;
      if (
        !id_escola ||
        !id_area ||
        !id_modalidade ||
        !id_professor ||
        !id_orientador
      ) {
        return res
          .status(400)
          .json({ error: "Dados da proposta incompletos." });
      }

      // 4) Cria registro de estágio (proposta)
      const propostaData = {
        id_estagiario,
        id_escola: parseInt(id_escola, 10),
        id_area: parseInt(id_area, 10),
        id_modalidade: parseInt(id_modalidade, 10),
        id_professor: parseInt(id_professor, 10),
        id_orientador: parseInt(id_orientador, 10),
        status: status || "pendente",
      };
      const proposta = await PropostaModel.create(propostaData);
      console.log("[propostaController.create] Proposta criada:", proposta);

      // 5) Processa o PDF enviado
      if (!req.file || !req.file.path) {
        return res.status(400).json({ error: "Arquivo PDF não enviado." });
      }
      const caminhoPDF = req.file.path;

      // 6) Calcula hash
      const hashDocumento = await calcularHashArquivoPDF(caminhoPDF);

      // 7) Salva metadados no documento_estagio usando id_estagio
      const doc = await DocumentoEstagioModel.create({
        id_estagio: proposta.id_estagio, // usa a coluna correta
        tipo_documento: "proposta",
        caminho_pdf: caminhoPDF,
        hash_documento: hashDocumento,
      });

      // 8) Registra no blockchain
      const resp = await fetch("http://localhost:8080/blockchain/registros", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_proposta: String(proposta.id_estagio),
          tipo_evento: "proposta_submetida",
          hash_documento: hashDocumento,
          assinatura: "assinatura_simples",
        }),
      });
      if (!resp.ok) {
        const text = await resp.text();
        console.error("[propostaController.create] Erro blockchain:", text);
        return res
          .status(502)
          .json({ error: "Falha ao registrar no blockchain." });
      }
      const bloco = await resp.json();

      // 9) Grava no registro local de blockchain
      await pool.query(
        `INSERT INTO blockchain_registro
         (id_estagio, id_documento, tipo_evento, hash_blockchain)
         VALUES ($1, $2, $3, $4)`,
        [
          proposta.id_estagio,
          doc.id_documento,
          bloco.tipo_evento,
          bloco.hash_bloco,
        ]
      );

      await pool.query(
        `INSERT INTO estagio_etapa
    (id_estagio, etapa, id_usuario_assinante, id_documento, hash_blockchain)
   VALUES ($1, $2, $3, $4, $5)`,
        [
          proposta.id_estagio,
          "inclusão",
          id_usuario,
          doc.id_documento,
          bloco.hash_bloco,
        ]
      );

      console.log(
        "[propostaController.create] Upload e blockchain concluídos",
        { doc, bloco }
      );

      return res.status(201).json({
        proposta,
        documento: doc,
        bloco,
      });
    } catch (error) {
      console.error(
        "[propostaController.create] Erro ao criar proposta + upload:",
        error
      );
      if (!res.headersSent) {
        res.status(500).json({ error: error.message });
      }
    }
  },

  // Upload de PDF e registro no blockchain
  async uploadDocumento(req, res) {
    try {
      const id_proposta = req.params.id_proposta || req.body.id_proposta;
      console.log(
        "[propostaController.uploadDocumento] id_proposta:",
        id_proposta
      );

      if (!id_proposta) {
        return res.status(400).json({ error: "ID da proposta ausente." });
      }

      const proposta = await PropostaModel.findById(id_proposta);
      if (!proposta) {
        return res.status(404).json({ error: "Proposta não encontrada." });
      }
      if (!req.file || !req.file.path) {
        return res.status(400).json({ error: "Arquivo não enviado." });
      }

      // Calcula hash do PDF
      const caminhoPDF = req.file.path;
      const hashDocumento = await calcularHashArquivoPDF(caminhoPDF);

      // Salva no banco de documentos
      const doc = await DocumentoEstagioModel.create({
        id_estagio: id_proposta,
        tipo_documento: "proposta",
        caminho_pdf: caminhoPDF,
        hash_documento: hashDocumento,
      });

      // Registro em blockchain: id_proposta como string
      const resp = await fetch("http://localhost:8080/blockchain/registros", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_proposta: id_proposta.toString(),
          tipo_evento: "upload_documento",
          hash_documento: hashDocumento,
          assinatura: "assinatura_simples",
        }),
      });

      if (!resp.ok) {
        console.error(
          "[propostaController.uploadDocumento] Erro blockchain:",
          await resp.text()
        );
        return res
          .status(500)
          .json({ error: "Erro ao registrar no blockchain." });
      }

      const bloco = await resp.json();
      // Insere registro final no banco local
      await pool.query(
        `INSERT INTO blockchain_registro
         (id_proposta, id_documento, tipo_evento, hash_blockchain)
         VALUES ($1, $2, $3, $4)`,
        [id_proposta, doc.id_documento, bloco.tipo_evento, bloco.hash_bloco]
      );

      console.log(
        "[propostaController.uploadDocumento] Documento salvo e bloco registrado:"
      );
      return res.status(201).json({ documento: doc, bloco });
    } catch (error) {
      console.error(
        "[propostaController.uploadDocumento] Erro ao salvar documento:",
        error
      );
      return res.status(400).json({ error: error.message });
    }
  },

  // Depois (lista só as propostas relacionadas ao usuário)
  async findAll(req, res) {
    try {
      // ID do usuário (estagiário, professor ou orientador)
      const idUsuario = req.user.id_usuario ?? req.user.id;
      if (!idUsuario) {
        return res.status(401).json({ error: 'Usuário não autenticado.' });
      }
      // Busca só as propostas onde ele participa
      const propostas = await PropostaModel.findByUser(idUsuario);
      return res.json(propostas);
    } catch (error) {
      return res.status(500).json({ error: error.message });
    }
  },

  // Busca proposta por ID
  async findById(req, res) {
    try {
      const proposta = await PropostaModel.findById(req.params.id);
      if (!proposta) {
        return res.status(404).json({ error: "Proposta não encontrada." });
      }
      return res.json(proposta);
    } catch (error) {
      return res.status(500).json({ error: error.message });
    }
  },

  // Atualiza proposta
  async update(req, res) {
    try {
      const payload = req.user;
      const propostaData = {
        id_estagiario: payload.id_usuario,
        id_escola: req.body.id_escola,
        id_area: req.body.id_area,
        id_modalidade: req.body.id_modalidade,
        id_professor: req.body.id_professor,
        id_orientador: req.body.id_orientador,
        status: req.body.status || "pendente",
      };
      const proposta = await PropostaModel.update(req.params.id, propostaData);
      if (!proposta) {
        return res.status(404).json({ error: "Proposta não encontrada." });
      }
      return res.json(proposta);
    } catch (error) {
      return res.status(400).json({ error: error.message });
    }
  },

  // Remove proposta
  async remove(req, res) {
    try {
      await PropostaModel.remove(req.params.id);
      return res.json({ message: "Proposta removida com sucesso." });
    } catch (error) {
      return res.status(500).json({ error: error.message });
    }
  },
};

module.exports = propostaController;
