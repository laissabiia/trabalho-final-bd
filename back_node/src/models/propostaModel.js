// src/models/propostaModel.js
const pool = require("./db");

// Model para gerenciar propostas de estágio, agora usando a tabela 'estagio'
const PropostaModel = {
  // Cria uma nova proposta/estágio
  async create({ id_estagiario, id_professor, id_escola, id_area, id_modalidade, status }) {
    const result = await pool.query(
      `INSERT INTO estagio
       (id_estagiario, id_professor, id_escola, id_area, id_modalidade, status)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [id_estagiario, id_professor, id_escola, id_area, id_modalidade, status]
    );
    return result.rows[0];
  },

  // Lista todas as propostas/estágios
  async findAll() {
    const result = await pool.query(
      "SELECT * FROM estagio"
    );
    return result.rows;
  },

  // Busca uma proposta/estágio por ID
  async findById(id) {
    const result = await pool.query(
      "SELECT * FROM estagio WHERE id_estagio = $1",
      [id]
    );
    return result.rows[0];
  },

  // Atualiza campos de uma proposta/estágio existente
  async update(id, fields) {
    const keys = Object.keys(fields);
    const values = Object.values(fields);
    if (keys.length === 0) return null;
    const setQuery = keys.map((k, i) => `${k} = $${i + 1}`).join(", ");
    const result = await pool.query(
      `UPDATE estagio SET ${setQuery} WHERE id_estagio = $${keys.length + 1} RETURNING *`,
      [...values, id]
    );
    return result.rows[0];
  },

  // Remove uma proposta/estágio pelo ID
  async remove(id) {
    await pool.query(
      "DELETE FROM estagio WHERE id_estagio = $1",
      [id]
    );
  }
};

module.exports = PropostaModel;
