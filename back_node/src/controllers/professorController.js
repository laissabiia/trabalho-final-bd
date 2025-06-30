// src/controllers/professorController.js
const ProfessorModel = require('../models/professorModel');

const professorController = {
  /**
   * GET /api/professores
   * Query params:
   *   - escola: filtra professores vinculados a aquela escola
   *   - area:   filtra professores vinculados a aquela área
   */
  async getProfessores(req, res) {
    try {
      const { escola, area } = req.query;
      const professores = await ProfessorModel.findAll({ escola, area });
      res.json(professores);
    } catch (error) {
      console.error('[professorController] Erro ao buscar professores:', error);
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = professorController;
