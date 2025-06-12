const pool = require('./db');

const CursoModel = {
  async findAll() {
    const result = await pool.query('SELECT id_curso, nome FROM curso ORDER BY nome');
    return result.rows;
  }
};

module.exports = CursoModel;
