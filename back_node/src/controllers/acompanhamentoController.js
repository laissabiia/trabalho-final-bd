// src/controllers/acompanhamentoController.js
const fs = require('fs');
const PropostaModel = require('../models/propostaModel');
const EstagioEtapaModel = require('../models/estagioEtapaModel');
const DocumentoEstagioModel = require('../models/documentoEstagioModel');
const blockchainService = require('../services/blockchainService');
const crypto = require('crypto');

/**
 * Controller para acompanhamento de estágios: GET para exibir dados e POST para registrar nova etapa
 */
const AcompanhamentoController = {
  /**
   * GET /api/propostas/:id/acompanhamento
   * Retorna detalhes do estágio, histórico de etapas e dados gerais do blockchain
   */
  async getAcompanhamento(req, res) {
    try {
      const idEstagio = parseInt(req.params.id, 10);
      const proposta = await PropostaModel.findById(idEstagio);
      if (!proposta) {
        return res.status(404).json({ error: 'Estágio não encontrado.' });
      }
      const etapas = await EstagioEtapaModel.findByEstagio(idEstagio);
      const blockchain = await blockchainService.getChainData(idEstagio);
      return res.json({ estagio: proposta, etapas, blockchain });
    } catch (err) {
      console.error('[AcompanhamentoController.getAcompanhamento] erro:', err);
      return res.status(500).json({ error: 'Erro ao buscar acompanhamento.' });
    }
  },

  /**
   * POST /api/propostas/:id/acompanhamento
   * Recebe mensagem e/ou arquivo, registra no blockchain e persiste na tabela estagio_etapa
   */
  async acompanhamento(req, res) {
    try {
      const idEstagio = parseInt(req.params.id, 10);
      const idUsuario = req.user.id_usuario ?? req.user.id;
      if (!idUsuario) {
        return res.status(401).json({ error: 'Usuário não autenticado.' });
      }
      const mensagem = req.body.mensagem;

      // Tratamento de upload de documento (PDF)
      let idDocumento = null;
      let hashDocumento = null;
      if (req.file) {
        let arquivoBuffer;
        // memória ou disco
        if (req.file.buffer) {
          arquivoBuffer = req.file.buffer;
        } else if (req.file.path) {
          arquivoBuffer = await fs.promises.readFile(req.file.path);
        }
        if (arquivoBuffer) {
          hashDocumento = crypto
            .createHash('sha256')
            .update(arquivoBuffer)
            .digest('hex');

          const doc = await DocumentoEstagioModel.create({
            id_estagio: idEstagio,
            tipo_documento: 'acompanhamento',
            arquivo_pdf: arquivoBuffer,
            hash_documento: hashDocumento
          });
          idDocumento = doc.id_documento;
        }
      }

      // Define descrição da etapa
      let etapaDesc = '';
      if (mensagem && idDocumento) etapaDesc = 'Mensagem e Documento Enviados';
      else if (mensagem) etapaDesc = 'Mensagem Enviada';
      else if (idDocumento) etapaDesc = 'Documento Enviado';
      else etapaDesc = 'Atualização';

      // Registra no blockchain
      const bcResult = await blockchainService.registerStep({
        idEstagio,
        etapa: etapaDesc,
        idUsuario,
        idDocumento,
        mensagem
      });

      // Persiste no banco de dados
      const etapa = await EstagioEtapaModel.create({
        id_estagio: idEstagio,
        etapa: etapaDesc,
        id_usuario_assinante: idUsuario,
        id_documento: idDocumento,
        hash_blockchain: bcResult.hash
      });

      return res.status(201).json({ etapa });
    } catch (err) {
      console.error('[AcompanhamentoController.acompanhamento] erro:', err);
      return res.status(500).json({ error: 'Erro ao registrar acompanhamento.' });
    }
  }
};

module.exports = AcompanhamentoController;
