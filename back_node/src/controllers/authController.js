const UsuarioModel = require('../models/usuarioModel');
const PerfilUsuarioModel = require('../models/perfilUsuarioModel');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'segredo_supersecreto';

const authController = {
  async login(req, res) {
    const { email, senha } = req.body;
    try {
      const usuario = await UsuarioModel.findByEmail(email);
      if (!usuario) return res.status(401).json({ error: 'Usuário ou senha inválidos' });

      const senhaCorreta = await bcrypt.compare(senha, usuario.senha);
      if (!senhaCorreta) return res.status(401).json({ error: 'Usuário ou senha inválidos' });

      const perfis = await PerfilUsuarioModel.getTiposDoUsuario(usuario.id_usuario);
      const token = jwt.sign(
        {
          id_usuario: usuario.id_usuario,
          email: usuario.email,
          perfis: perfis.map(p => p.nome)
        },
        JWT_SECRET,
        { expiresIn: '6h' }
      );
      res.json({
        usuario: { id_usuario: usuario.id_usuario, nome: usuario.nome, email: usuario.email, perfis },
        token
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = authController;
