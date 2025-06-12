const AreaModel = require('../models/areaModel');

const areaController = {
  async findAll(req, res) {
    try {
      const areas = await AreaModel.findAll();
      res.json(areas);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = areaController;
