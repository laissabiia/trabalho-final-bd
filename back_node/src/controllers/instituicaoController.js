const InstituicaoModel = require('../models/instituicaoModel');

const instituicaoController = {
  async findAll(req, res) {
    try {
      const instituicoes = await InstituicaoModel.findAll();
      res.json(instituicoes);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = instituicaoController;
