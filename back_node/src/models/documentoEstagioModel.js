// src/models/documentoEstagioModel.js
const pool = require('./db');

/**
 * Model para gerenciar documentos de estágio (tabela documento_estagio)
 */
const DocumentoEstagioModel = {
  /**
   * Insere um novo documento de estágio
   * @param {{ id_estagio: number, tipo_documento: string, caminho_pdf: string }} data
   * @returns {Promise<object>} documento criado
   */
  async create({ id_estagio, tipo_documento, caminho_pdf }) {
    const result = await pool.query(
      `INSERT INTO documento_estagio
         (id_estagio, tipo_documento, caminho_pdf)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [id_estagio, tipo_documento, caminho_pdf]
    );
    return result.rows[0];
  },

  /**
   * Busca um documento pelo ID
   */
  async findById(id_documento) {
    const result = await pool.query(
      `SELECT * FROM documento_estagio WHERE id_documento = $1`,
      [id_documento]
    );
    return result.rows[0];
  },

  /**
   * Lista todos os documentos de um estágio
   */
  async findByEstagio(id_estagio) {
    const result = await pool.query(
      `SELECT * FROM documento_estagio
         WHERE id_estagio = $1
       ORDER BY data_envio ASC`,
      [id_estagio]
    );
    return result.rows;
  }
};

module.exports = DocumentoEstagioModel;
