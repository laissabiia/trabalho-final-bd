const pool = require('./db');

const PerfilUsuarioModel = {
  // Lista todos os tipos possíveis
  async getTipos() {
    const result = await pool.query('SELECT * FROM tipo_usuario ORDER BY id_tipo');
    return result.rows;
  },

  // Lista os tipos de um usuário específico
  async getTiposDoUsuario(id_usuario) {
    const result = await pool.query(
      `SELECT t.* FROM perfil_usuario p
       JOIN tipo_usuario t ON p.id_tipo = t.id_tipo
       WHERE p.id_usuario = $1`,
      [id_usuario]
    );
    return result.rows;
  },

  // Associa um tipo a um usuário
  async addTipoAoUsuario(id_usuario, id_tipo) {
    const result = await pool.query(
      'INSERT INTO perfil_usuario (id_usuario, id_tipo) VALUES ($1, $2) RETURNING *',
      [id_usuario, id_tipo]
    );
    return result.rows[0];
  },

  // Remove um tipo de um usuário
  async removeTipoDoUsuario(id_usuario, id_tipo) {
    await pool.query(
      'DELETE FROM perfil_usuario WHERE id_usuario = $1 AND id_tipo = $2',
      [id_usuario, id_tipo]
    );
  }
};

module.exports = PerfilUsuarioModel;
