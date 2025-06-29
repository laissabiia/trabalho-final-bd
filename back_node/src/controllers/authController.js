// src/controllers/authController.js
const UsuarioModel = require("../models/usuarioModel");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// Controlador de autenticação
const authController = {
  async login(req, res) {
    const { email, senha } = req.body;
    try {
      // Busca usuário pelo email
      const usuario = await UsuarioModel.findByEmail(email);
      if (!usuario) {
        return res.status(400).json({ error: "Usuário não encontrado" });
      }
      // Verifica senha
      const match = await bcrypt.compare(senha, usuario.senha);
      if (!match) {
        return res.status(400).json({ error: "Senha inválida" });
      }
      // Usa o mesmo segredo padrão do middleware de autenticação
      const jwtSecret = process.env.JWT_SECRET || "segredo_supersecreto";
      if (!process.env.JWT_SECRET) console.warn("[authController.login] JWT_SECRET não definido, usando default do sistema");
      // Gera token JWT
      const token = jwt.sign(
        { id: usuario.id_usuario, email: usuario.email },
        jwtSecret,
        { expiresIn: "1h" }
      );
      res.json({ token });
    } catch (error) {
      console.error("[authController.login] Erro ao autenticar:", error);
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = authController;
