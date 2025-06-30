// src/models/areaModel.js
const pool = require('./db');

const AreaModel = {
  /**
   * Retorna áreas, filtrando opcionalmente por escola vinculada
   * @param {{ escola?: string }} filters
   */
  async findAll(filters = {}) {
    const { escola } = filters;
    let query = `
      SELECT DISTINCT a.*
      FROM area a
    `;
    const params = [];
    let idx = 1;

    if (escola) {
      // Somente áreas que têm professores vinculados à escola
      query += `
        JOIN professor_area pa ON pa.id_area = a.id_area
        JOIN professor p ON p.id_professor = pa.id_professor
        WHERE p.id_escola = $${idx}
      `;
      params.push(escola);
    }

    query += `
      ORDER BY a.nome
    `;

    const result = await pool.query(query, params);
    return result.rows;
  }
};

module.exports = AreaModel;
