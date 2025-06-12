const pool = require('./db');

const AreaModel = {
  async findAll() {
    const result = await pool.query('SELECT id_area, nome FROM area ORDER BY nome');
    return result.rows;
  }
};

module.exports = AreaModel;
