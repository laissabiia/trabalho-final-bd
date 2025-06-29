// src/models/perfilUsuarioModel.js
const pool = require("./db");

// Model para gerenciar o perfil de usuário, usando a coluna id_tipo em usuario
const PerfilUsuarioModel = {
  // Retorna o perfil (tipo) associado ao usuário
  async getTiposDoUsuario(idUsuario) {
    const result = await pool.query(
      `SELECT t.id_tipo, t.nome
       FROM usuario u
       JOIN tipo_usuario t ON u.id_tipo = t.id_tipo
       WHERE u.id_usuario = $1`,
      [idUsuario]
    );
    return result.rows;
  },

  // Define (ou altera) o perfil de usuário
  async addTipoAoUsuario(idUsuario, idTipo) {
    await pool.query(
      `UPDATE usuario SET id_tipo = $1 WHERE id_usuario = $2`,
      [idTipo, idUsuario]
    );
  },

  // Remove o perfil do usuário (se necessário)
  async removeTipoDoUsuario(idUsuario) {
    // A coluna id_tipo não permite NULL por constraints, avalie outra estratégia se precisar remover
    await pool.query(
      `UPDATE usuario SET id_tipo = NULL WHERE id_usuario = $1`,
      [idUsuario]
    );
  }
};

module.exports = PerfilUsuarioModel;
