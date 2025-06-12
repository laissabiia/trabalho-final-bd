const EscolaModel = require('../models/escolaModel');

const escolaController = {
  async findAll(req, res) {
    try {
      const escolas = await EscolaModel.findAll();
      res.json(escolas);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = escolaController;
