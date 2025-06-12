// routes/usuarioRoutes.js (unificado com perfilUsuarioRoutes)
const express = require('express');
const router = express.Router();

const usuarioController = require('../controllers/usuarioController');
const perfilUsuarioController = require('../controllers/perfilUsuarioController');
const authMiddleware = require('../middleware/authMiddleware');

// --- ROTAS PÚBLICAS ---
router.post('/', usuarioController.create); // Cadastro de usuário
router.get('/tipos', perfilUsuarioController.getTipos); // Lista de tipos públicos

// --- MIDDLEWARE DE AUTENTICAÇÃO ---
router.use(authMiddleware);

// --- ROTAS PROTEGIDAS USUÁRIO ---
router.get('/', usuarioController.findAll);
router.get('/:id', usuarioController.findById);
router.put('/:id', usuarioController.update);
router.delete('/:id', usuarioController.remove);

// --- ROTAS PROTEGIDAS PERFIL USUÁRIO ---
router.get('/:id/tipos', perfilUsuarioController.getTiposDoUsuario);
router.post('/:id/tipos', perfilUsuarioController.addTipoAoUsuario);
router.delete('/:id/tipos/:id_tipo', perfilUsuarioController.removeTipoDoUsuario);

module.exports = router;
