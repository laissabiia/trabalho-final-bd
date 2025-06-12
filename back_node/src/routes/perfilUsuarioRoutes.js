const express = require('express');
const router = express.Router();
const perfilUsuarioController = require('../controllers/perfilUsuarioController');
const authMiddleware = require('../middleware/authMiddleware');

// --- ROTAS PÚBLICAS ---
router.get('/tipos', (req, res, next) => {
  console.log('[ROUTER] Rota /api/usuarios/tipos chamada');
  next();
}, perfilUsuarioController.getTipos);

// --- ROTAS PROTEGIDAS ---
router.use(authMiddleware);

router.get('/:id/tipos', perfilUsuarioController.getTiposDoUsuario);
router.post('/:id/tipos', perfilUsuarioController.addTipoAoUsuario);
router.delete('/:id/tipos/:id_tipo', perfilUsuarioController.removeTipoDoUsuario);

module.exports = router;
