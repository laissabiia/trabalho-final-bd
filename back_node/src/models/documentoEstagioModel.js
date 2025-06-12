const pool = require('./db');

const DocumentoEstagioModel = {
  async create({ id_proposta, tipo_documento, caminho_pdf }) {
    const result = await pool.query(
      `INSERT INTO documento_estagio
      (id_proposta, tipo_documento, caminho_pdf)
      VALUES ($1, $2, $3)
      RETURNING *`,
      [id_proposta, tipo_documento, caminho_pdf]
    );
    return result.rows[0];
  },

  async findByProposta(id_proposta) {
    const result = await pool.query('SELECT * FROM documento_estagio WHERE id_proposta = $1', [id_proposta]);
    return result.rows;
  }
};

module.exports = DocumentoEstagioModel;

