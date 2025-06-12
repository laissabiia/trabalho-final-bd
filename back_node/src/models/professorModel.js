const pool = require('./db');

const ProfessorModel = {
  async findAll() {
    const result = await pool.query(`
      SELECT p.id_professor, u.nome
      FROM professor p
      JOIN usuario u ON p.id_usuario = u.id_usuario
      ORDER BY u.nome
    `);
    return result.rows;
  }
};

module.exports = ProfessorModel;
