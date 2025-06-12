const pool = require('./db');

const InstituicaoModel = {
  async findAll() {
    const result = await pool.query('SELECT id_instituicao, nome FROM instituicao ORDER BY nome');
    return result.rows;
  }
};

module.exports = InstituicaoModel;
