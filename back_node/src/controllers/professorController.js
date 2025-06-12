const ProfessorModel = require('../models/professorModel');

const professorController = {
  async findAll(req, res) {
    try {
      const professores = await ProfessorModel.findAll();
      res.json(professores);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = professorController;
