const ModalidadeModel = require('../models/modalidadeModel');

const modalidadeController = {
  async findAll(req, res) {
    try {
      const modalidades = await ModalidadeModel.findAll();
      res.json(modalidades);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = modalidadeController;
