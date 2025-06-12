const pool = require('./db');

const EscolaModel = {
  async findAll() {
    const result = await pool.query('SELECT id_escola, nome FROM escola ORDER BY nome');
    return result.rows;
  }
};

module.exports = EscolaModel;
