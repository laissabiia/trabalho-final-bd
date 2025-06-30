// src/models/estagioEtapaModel.js
const pool = require('./db');

/**
 * Model para gerenciar etapas de estágio (tabela estagio_etapa)
 */
const EstagioEtapaModel = {
  /**
   * Insere um novo registro de etapa
   * @param {{ id_estagio: number, etapa: string, id_usuario_assinante: number, id_documento?: number, hash_blockchain: string, assinatura?: string, proof?: object }} data
   * @returns {Promise<object>} registro criado
   */
  async create(data) {
    const {
      id_estagio,
      etapa,
      id_usuario_assinante,
      id_documento = null,
      hash_blockchain
    } = data;

    const result = await pool.query(
      `INSERT INTO estagio_etapa
       (id_estagio, etapa, id_usuario_assinante, id_documento, hash_blockchain)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [id_estagio, etapa, id_usuario_assinante, id_documento, hash_blockchain]
    );
    return result.rows[0];
  },

  /**
   * Lista todas as etapas para um dado estágio
   * @param {number} id_estagio
   * @returns {Promise<object[]>} lista de etapas
   */
  async findByEstagio(id_estagio) {
    const result = await pool.query(
      `SELECT ee.*, u.nome AS usuario_nome
         FROM estagio_etapa ee
    LEFT JOIN usuario u ON u.id_usuario = ee.id_usuario_assinante
        WHERE ee.id_estagio = $1
     ORDER BY ee.data_inicio ASC`,
      [id_estagio]
    );
    return result.rows;
  }
};

module.exports = EstagioEtapaModel;
