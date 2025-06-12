const CursoModel = require('../models/cursoModel');

const cursoController = {
  async findAll(req, res) {
    try {
      const cursos = await CursoModel.findAll();
      res.json(cursos);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = cursoController;
