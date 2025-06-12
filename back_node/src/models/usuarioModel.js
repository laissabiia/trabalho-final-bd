const pool = require('./db');

const UsuarioModel = {
  // Cria um novo usuário
  async create(nome, email, senha) {
    const result = await pool.query(
      'INSERT INTO usuario (nome, email, senha) VALUES ($1, $2, $3) RETURNING *',
      [nome, email, senha]
    );
    return result.rows[0];
  },

  // Lista todos os usuários
  async findAll() {
    const result = await pool.query('SELECT * FROM usuario');
    return result.rows;
  },

  // Busca usuário por ID
  async findById(id) {
    const result = await pool.query('SELECT * FROM usuario WHERE id_usuario = $1', [id]);
    return result.rows[0];
  },

// Busca usuário pelo e-mail
async findByEmail(email) {
  const result = await pool.query('SELECT * FROM usuario WHERE email = $1', [email]);
  return result.rows[0];
},

  // Atualiza usuário
  async update(id, nome, email, senha) {
    const result = await pool.query(
      'UPDATE usuario SET nome = $1, email = $2, senha = $3 WHERE id_usuario = $4 RETURNING *',
      [nome, email, senha, id]
    );
    return result.rows[0];
  },

  // Remove usuário
  async remove(id) {
    await pool.query('DELETE FROM usuario WHERE id_usuario = $1', [id]);
  }
};

module.exports = UsuarioModel;
