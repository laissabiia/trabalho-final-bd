// src/models/documentoEstagioModel.js

const pool = require('./db');

/**
 * Model para gerenciar documentos de estágio (tabela documento_estagio)
 */
const DocumentoEstagioModel = {
  /**
   * Cria um novo registro de documento de estágio
   * @param {{ id_estagio: number, tipo_documento: string, arquivo_pdf: Buffer, hash_documento: string }} data
   * @returns {Promise<object>} objeto criado
   */
  async create(data) {
    const {
      id_estagio,
      tipo_documento,
      arquivo_pdf,
      hash_documento
    } = data;

    const result = await pool.query(
      `INSERT INTO documento_estagio
         (id_estagio, tipo_documento, arquivo_pdf, hash_documento)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [
        id_estagio,
        tipo_documento,
        arquivo_pdf,
        hash_documento
      ]
    );
    return result.rows[0];
  },

  /**
   * Busca um documento por ID
   * @param {number} id_documento
   * @returns {Promise<object|null>}
   */
  async findById(id_documento) {
    const result = await pool.query(
      `SELECT id_documento, id_estagio, tipo_documento,
              encode(hash_documento::bytea, 'hex') AS hash_documento,
              arquivo_pdf, data_envio
         FROM documento_estagio
        WHERE id_documento = $1`,
      [id_documento]
    );
    return result.rows[0] || null;
  },

  /**
   * Lista todos os documentos de um estagio
   * @param {number} id_estagio
   * @returns {Promise<object[]>}
   */
  async findByEstagio(id_estagio) {
    const result = await pool.query(
      `SELECT id_documento, tipo_documento,
              encode(hash_documento::bytea, 'hex') AS hash_documento,
              data_envio
         FROM documento_estagio
        WHERE id_estagio = $1
     ORDER BY data_envio ASC`,
      [id_estagio]
    );
    return result.rows;
  },

  /**
   * Remove um documento pelo ID
   * @param {number} id_documento
   * @returns {Promise<void>}
   */
  async remove(id_documento) {
    await pool.query(
      `DELETE FROM documento_estagio WHERE id_documento = $1`,
      [id_documento]
    );
  }
};

module.exports = DocumentoEstagioModel;
