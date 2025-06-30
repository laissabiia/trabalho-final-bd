// src/models/professorModel.js
const pool = require('./db');

const ProfessorModel = {
  /**
   * Retorna professores, filtrando opcionalmente por escola e/ou área
   * @param {{ escola?: string, area?: string }} filters
   */
  async findAll(filters = {}) {
    const { escola, area } = filters;
    let idx = 1;
    const params = [];

    // Base da query: seleciona dados do professor e nome de usuário
    let query = `
      SELECT DISTINCT p.id_professor,
                      p.id_usuario,
                      p.id_escola,
                      u.nome AS nome
      FROM professor p
      JOIN usuario u ON u.id_usuario = p.id_usuario
    `;

    // Filtro por escola
    if (escola) {
      query += ` WHERE p.id_escola = $${idx}`;
      params.push(escola);
      idx++;
    }

    // Filtro por área via tabela de relacionamento
    if (area) {
      if (escola) {
        query += ` AND EXISTS (
          SELECT 1
          FROM professor_area pa
          WHERE pa.id_professor = p.id_professor
            AND pa.id_area = $${idx}
        )`;
      } else {
        query += ` WHERE EXISTS (
          SELECT 1
          FROM professor_area pa
          WHERE pa.id_professor = p.id_professor
            AND pa.id_area = $${idx}
        )`;
      }
      params.push(area);
      idx++;
    }

    // Ordena pelo nome do usuário
    query += ` ORDER BY u.nome`;

    const result = await pool.query(query, params);
    return result.rows;
  }
};

module.exports = ProfessorModel;
