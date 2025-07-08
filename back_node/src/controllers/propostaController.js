// src/controllers/propostaController.js

const PropostaModel = require("../models/propostaModel");
const DocumentoEstagioModel = require("../models/documentoEstagioModel");
const pool = require("../models/db");
const fetch = require("node-fetch").default;
const crypto = require("crypto");

const propostaController = {
  // Cria nova proposta e faz upload inicial do PDF
  async create(req, res) {
    let proposta;
    try {
      console.log("[propostaController.create] req.user:", req.user);

      // 1) Extrai ID do usuário do token
      const id_usuario =
        (req.user.id_usuario && parseInt(req.user.id_usuario, 10)) ||
        (req.user.id && parseInt(req.user.id, 10));

      // 2) Verifica se é estagiário
      const est = await pool.query(
        "SELECT id_estagiario, id_instituicao FROM estagiario WHERE id_usuario = $1",
        [id_usuario]
      );
      if (est.rows.length === 0) {
        return res.status(403).json({ error: "Usuário não é estagiário." });
      }
      const { id_estagiario, id_instituicao } = est.rows[0];

      // 3) Desestrutura e valida campos da requisição
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
        id_instituicao,
        id_escola,
        id_area,
        id_modalidade,
        id_professor,
        id_orientador,
        status: status || "submetida",
      };
      proposta = await PropostaModel.create(propostaData);
      console.log(
        "[propostaController.create] Proposta criada:",
        proposta.id_estagio
      );

      // 5) Verifica e obtém o arquivo enviado em memória
      if (!req.file || !req.file.buffer) {
        return res.status(400).json({ error: "Arquivo não enviado." });
      }
      const arquivoBuffer = req.file.buffer;

      // 6) Calcula hash do PDF
      const hashDocumento = crypto
        .createHash("sha256")
        .update(arquivoBuffer)
        .digest("hex");

      // 7) Salva metadados no documento_estagio usando id_estagio e binário
      const doc = await DocumentoEstagioModel.create({
        id_estagio: proposta.id_estagio,
        tipo_documento: "proposta",
        arquivo_pdf: arquivoBuffer,
        hash_documento: hashDocumento,
      });

      console.log(
        "[propostaController.create] Documento criado:",
        doc.id_documento
      );

      // 8) Registra evento no blockchain
      const resp = await fetch("http://localhost:8080/blockchain/registros", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_proposta: proposta.id_estagio.toString(),
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

      // 9) Grava registro de blockchain no banco local
      await pool.query(
        `INSERT INTO blockchain_registro
         (id_estagio, id_documento, tipo_evento, hash_blockchain)
         VALUES ($1, $2, $3, $4)`,
        [proposta.id_estagio, doc.id_documento, bloco.tipo_evento, bloco.hash_bloco]
      );

      // 10) Registra etapa "inclusão" no estagio_etapa
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
        "[propostaController.create] Upload e blockchain concluídos"
      );
      return res.status(201).json({ id_proposta: proposta.id_estagio });
    } catch (error) {
      console.error("[propostaController.create] Erro:", error);
      if (!res.headersSent) {
        return res.status(400).json({ error: error.message });
      }
    }
  },

  // Upload adicional de PDF (ou outros documentos) para uma proposta existente
  async uploadDocumento(req, res) {
    try {
      const id_proposta = req.params.id_proposta || req.body.id_proposta;
      console.log(
        "[propostaController.uploadDocumento] id_proposta:",
        id_proposta
      );

      if (!id_proposta || isNaN(parseInt(id_proposta, 10))) {
        return res
          .status(400)
          .json({ error: "ID da proposta inválido ou ausente." });
      }

      const proposta = await PropostaModel.findById(id_proposta);
      if (!proposta) {
        return res.status(404).json({ error: "Proposta não encontrada." });
      }

      if (!req.file || !req.file.buffer) {
        return res.status(400).json({ error: "Arquivo não enviado." });
      }
      const arquivoBuffer = req.file.buffer;

      // Calcula hash do novo PDF
      const hashDocumento = crypto
        .createHash("sha256")
        .update(arquivoBuffer)
        .digest("hex");

      // Salva no documento_estagio
      const doc = await DocumentoEstagioModel.create({
        id_estagio: parseInt(id_proposta, 10),
        tipo_documento: req.body.tipo_documento || "upload_documento",
        arquivo_pdf: arquivoBuffer,
        hash_documento: hashDocumento,
      });

      console.log("[propostaController.uploadDocumento] Documento salvo:", doc.id_documento);

      // Registra no blockchain
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
          .status(502)
          .json({ error: "Falha ao registrar no blockchain." });
      }
      const bloco = await resp.json();

      // Grava registro local de blockchain
      await pool.query(
        `INSERT INTO blockchain_registro
         (id_estagio, id_documento, tipo_evento, hash_blockchain)
         VALUES ($1, $2, $3, $4)`,
        [
          parseInt(id_proposta, 10),
          doc.id_documento,
          bloco.tipo_evento || "upload_documento",
          bloco.hash_bloco,
        ]
      );

      console.log(
        "[propostaController.uploadDocumento] Bloco registrado:",
        bloco
      );
      return res.status(201).json({ documento: doc, bloco });
    } catch (error) {
      console.error("[propostaController.uploadDocumento] Erro:", error);
      return res.status(400).json({ error: error.message });
    }
  },

  // Lista todas as propostas relacionadas ao usuário
  async findAll(req, res) {
    try {
      const idUsuario = req.user.id_usuario ?? req.user.id;
      if (!idUsuario) {
        return res.status(401).json({ error: "Usuário não autenticado." });
      }
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

  // Atualiza dados da proposta
  async update(req, res) {
    try {
      const updated = await PropostaModel.update(req.params.id, req.body);
      return res.json(updated);
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
