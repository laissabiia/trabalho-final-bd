// src/routes/orientadorRoutes.js
const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const orientadorController = require('../controllers/orientadorController');

// Todas as rotas de orientador exigem autenticação
router.use(authMiddleware);

/**
 * GET /api/orientadores
 * Query params:
 *   - instituicao: filtra orientadores por instituição
 */
router.get('/', orientadorController.getOrientadores);

module.exports = router;
