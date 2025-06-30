// src/controllers/orientadorController.js
const pool = require('../models/db');

const orientadorController = {
  /**
   * GET /api/orientadores
   * Query params:
   *   - instituicao: retorna todos os orientadores daquela instituição
   */
  async getOrientadores(req, res) {
    try {
      const { instituicao } = req.query;
      let query = `
        SELECT o.id_orientador,
               o.id_usuario,
               o.id_instituicao,
               u.nome
        FROM orientador o
        JOIN usuario u ON u.id_usuario = o.id_usuario
      `;
      const params = [];
      if (instituicao) {
        query += ` WHERE o.id_instituicao = $1`;
        params.push(instituicao);
      }
      query += ` ORDER BY u.nome`;

      const { rows } = await pool.query(query, params);
      return res.json(rows);
    } catch (error) {
      console.error('[orientadorController] Erro ao buscar orientadores:', error);
      return res.status(500).json({ error: error.message });
    }
  }
};

module.exports = orientadorController;
