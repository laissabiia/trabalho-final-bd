// src/controllers/escolaController.js
const EscolaModel = require('../models/escolaModel');

const escolaController = {
  /**
   * GET /api/escolas
   * Query params:
   *   - area: filtra escolas que tenham professores vinculados a essa área
   *   - professor: filtra escolas que tenham esse professor vinculado
   */
  async getEscolas(req, res) {
    try {
      const { area, professor } = req.query;
      const escolas = await EscolaModel.findAll({ area, professor });
      res.json(escolas);
    } catch (error) {
      console.error('[escolaController] Erro ao buscar escolas:', error);
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = escolaController;
