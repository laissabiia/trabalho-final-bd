// src/models/escolaModel.js
const pool = require('./db');

const EscolaModel = {
  /**
   * Retorna escolas, opcionalmente filtrando por área ou professor.
   * @param {{ area?: string, professor?: string }} filters
   */
  async findAll(filters = {}) {
    const { area, professor } = filters;
    const params = [];
    let idx = 1;

    // Inicia a query básica
    let query = `
      SELECT e.*
      FROM escola e
    `;

    // Filtrar por professor associado
    if (professor) {
      query += `
        JOIN professor p_prof ON p_prof.id_escola = e.id_escola
        WHERE p_prof.id_professor = $${idx}
      `;
      params.push(professor);
      idx++;
    }

    // Filtrar por área via professor_area
    if (area) {
      if (professor) {
        query += `
          AND EXISTS (
            SELECT 1 FROM professor_area pa
            WHERE pa.id_professor = p_prof.id_professor
              AND pa.id_area = $${idx}
          )
        `;
      } else {
        query += `
          JOIN professor p_area ON p_area.id_escola = e.id_escola
          JOIN professor_area pa ON pa.id_professor = p_area.id_professor
          WHERE pa.id_area = $${idx}
        `;
      }
      params.push(area);
      idx++;
    }

    // Se não há filtros, não aplica nenhum JOIN extra e retorna todas as escolas

    // Ordenação
    query += ` ORDER BY e.nome`;

    const result = await pool.query(query, params);
    return result.rows;
  }
};

module.exports = EscolaModel;
