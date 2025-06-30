// src/routes/professorRoutes.js
const express = require('express');
const router = express.Router();

const professorController = require('../controllers/professorController');
const authMiddleware = require('../middleware/authMiddleware');

// Protege todas as rotas de professor
router.use(authMiddleware);

/**
 * GET /api/professores
 * Query params:
 *   - escola: filtra professores vinculados àquela escola
 *   - area: filtra professores vinculados àquela área
 */
router.get('/', professorController.getProfessores);

module.exports = router;
