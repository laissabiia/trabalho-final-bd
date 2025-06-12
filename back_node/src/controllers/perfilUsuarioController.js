const PerfilUsuarioModel = require('../models/perfilUsuarioModel');

const perfilUsuarioController = {
  // Lista todos os tipos de perfil existentes
  async getTipos(req, res) {
    try {
      const tipos = await PerfilUsuarioModel.getTipos();
      res.json(tipos);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Lista os perfis (tipos) de um usuário
  async getTiposDoUsuario(req, res) {
    try {
      const { id } = req.params;
      const tipos = await PerfilUsuarioModel.getTiposDoUsuario(id);
      res.json(tipos);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Adiciona um tipo ao usuário
  async addTipoAoUsuario(req, res) {
    try {
      const { id } = req.params;
      const { id_tipo } = req.body;
      const perfil = await PerfilUsuarioModel.addTipoAoUsuario(id, id_tipo);
      res.status(201).json(perfil);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  },

  // Remove um tipo do usuário
  async removeTipoDoUsuario(req, res) {
    try {
      const { id, id_tipo } = req.params;
      await PerfilUsuarioModel.removeTipoDoUsuario(id, id_tipo);
      res.json({ message: 'Tipo removido do usuário com sucesso' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = perfilUsuarioController;
