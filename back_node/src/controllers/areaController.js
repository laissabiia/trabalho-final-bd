// src/controllers/areaController.js
const AreaModel = require('../models/areaModel');

const areaController = {
  /**
   * GET /api/areas
   * Query params:
   *   - escola: filtra áreas que tenham professores vinculados àquela escola
   */
  async getAreas(req, res) {
    try {
      const { escola } = req.query;
      const areas = await AreaModel.findAll({ escola });
      res.json(areas);
    } catch (error) {
      console.error('[areaController] Erro ao buscar áreas:', error);
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = areaController;
