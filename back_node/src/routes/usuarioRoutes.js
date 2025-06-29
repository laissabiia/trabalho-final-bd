// routes/usuarioRoutes.js
console.log("[usuarioRoutes] Módulo carregado");
const express = require('express');
const router = express.Router();

const usuarioController = require('../controllers/usuarioController');
const perfilUsuarioController = require('../controllers/perfilUsuarioController');
const authMiddleware = require('../middleware/authMiddleware');

// --- ROTAS PÚBLICAS ---
// Cria usuário
router.post('/', (req, res, next) => {
  console.log("[usuarioRoutes] POST / - Payload:", req.body);
  return usuarioController.create(req, res, next);
});
// Lista tipos de usuário disponíveis
router.get('/tipos', (req, res, next) => {
  console.log("[usuarioRoutes] GET /tipos");
  return perfilUsuarioController.getTipos(req, res, next);
});

// --- Middleware de autenticação ---
// Todas as rotas abaixo exigem token JWT válido
router.use(authMiddleware);

// Rotas protegidas
// Retorna perfis de um usuário específico
router.get('/:id/tipos', (req, res, next) => {
  console.log(`[usuarioRoutes] GET /${req.params.id}/tipos`);
  return perfilUsuarioController.getTiposDoUsuario(req, res, next);
});

// Outras rotas protegidas de usuário podem ser adicionadas aqui

module.exports = router;
