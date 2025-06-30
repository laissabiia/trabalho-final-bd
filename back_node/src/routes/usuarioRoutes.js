// src/routes/usuarioRoutes.js
const express = require('express');
const router = express.Router();

const usuarioController = require('../controllers/usuarioController');
const perfilUsuarioController = require('../controllers/perfilUsuarioController');
const authMiddleware = require('../middleware/authMiddleware');

// --- ROTAS PÚBLICAS ---
// Cria usuário
router.post('/', usuarioController.create);
// Lista tipos de usuário disponíveis
router.get('/tipos', perfilUsuarioController.getTipos);

// Autenticação para rotas protegidas
router.use(authMiddleware);

// Retorna perfis de um usuário específico (aluno, professor, orientador)
router.get('/:id/tipos', perfilUsuarioController.getTiposDoUsuario);

// Novo: retorna perfis detalhados (estagiário, professor, orientador) com vínculos
router.get('/:id/perfil', usuarioController.getPerfil);

module.exports = router;
