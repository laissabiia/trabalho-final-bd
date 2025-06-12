const pool = require('./db');

const ModalidadeModel = {
  async findAll() {
    const result = await pool.query('SELECT id_modalidade, nome FROM modalidade ORDER BY nome');
    return result.rows;
  }
};

module.exports = ModalidadeModel;
