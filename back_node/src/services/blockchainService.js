// src/services/blockchainService.js
const axios = require('axios');

// Base URL da API do microserviço blockchain
const BLOCKCHAIN_API_URL = process.env.BLOCKCHAIN_API_URL || 'http://127.0.0.1:8080';

/**
 * Serviço para interação com o microserviço blockchain
 */
const blockchainService = {
  /**
   * Registra uma nova etapa no blockchain (POST /blockchain/registros)
   * @param {{ idEstagio: number, etapa: string, idUsuario: number, idDocumento?: number, mensagem?: string }} data
   * @returns {Promise<{ hash: string, assinatura: string, proof: { timestamp: string, nonce: number, hash_anterior: string } }>} resultado da transação
   */
  async registerStep({ idEstagio, etapa, idUsuario, idDocumento, mensagem }) {
    // Monta payload conforme RegistroInput em main.rs
    const payload = {
      id_proposta: String(idEstagio),
      tipo_evento: etapa,
      hash_documento: idDocumento ? String(idDocumento) : '',
      assinatura: mensagem || ''
    };

    const resp = await axios.post(
      `${BLOCKCHAIN_API_URL}/blockchain/registros`,
      payload,
      { headers: { 'Content-Type': 'application/json' } }
    );

    const bloco = resp.data;
    return {
      hash: bloco.hash_bloco,
      assinatura: bloco.assinatura,
      proof: {
        timestamp: bloco.timestamp,
        nonce: bloco.nonce,
        hash_anterior: bloco.hash_anterior
      }
    };
  },

  /**
   * Obtém histórico completo de um estágio e retorna dados do último bloco
   * (GET /blockchain/historico/{id_proposta})
   * @param {number} idEstagio
   * @returns {Promise<{ lastHash: string|null, proof: object|null }>} dados do chain
   */
  async getChainData(idEstagio) {
    const resp = await axios.get(
      `${BLOCKCHAIN_API_URL}/blockchain/historico/${idEstagio}`
    );

    const historico = Array.isArray(resp.data) ? resp.data : [];
    if (!historico.length) {
      return { lastHash: null, proof: null };
    }
    const ultimo = historico[historico.length - 1];
    return {
      lastHash: ultimo.hash_bloco,
      proof: {
        id_proposta: ultimo.id_proposta,
        tipo_evento: ultimo.tipo_evento,
        hash_documento: ultimo.hash_documento,
        assinatura: ultimo.assinatura,
        timestamp: ultimo.timestamp,
        nonce: ultimo.nonce,
        hash_anterior: ultimo.hash_anterior
      }
    };
  }
};

module.exports = blockchainService;
