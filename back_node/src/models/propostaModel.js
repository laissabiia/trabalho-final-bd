const pool = require("./db");

const PropostaModel = {
  async create({
    id_estagiario,
    id_professor,
    id_escola,
    id_area,
    id_modalidade,
    status,
  }) {
    const result = await pool.query(
      `INSERT INTO proposta_estagio
    (id_estagiario, id_professor, id_escola, id_area, id_modalidade, status)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *`,
      [id_estagiario, id_professor, id_escola, id_area, id_modalidade, status]
    );
    return result.rows[0];
  },

  async findAll() {
    const result = await pool.query("SELECT * FROM proposta_estagio");
    return result.rows;
  },

  async findById(id) {
    const result = await pool.query(
      "SELECT * FROM proposta_estagio WHERE id_proposta = $1",
      [id]
    );
    return result.rows[0];
  },

  async update(id, fields) {
    const keys = Object.keys(fields);
    const values = Object.values(fields);
    if (keys.length === 0) return null;
    const setQuery = keys.map((k, i) => `${k} = $${i + 1}`).join(", ");
    const result = await pool.query(
      `UPDATE proposta_estagio SET ${setQuery} WHERE id_proposta = $${
        keys.length + 1
      } RETURNING *`,
      [...values, id]
    );
    return result.rows[0];
  },

  async remove(id) {
    await pool.query("DELETE FROM proposta_estagio WHERE id_proposta = $1", [
      id,
    ]);
  },
};

module.exports = PropostaModel;
