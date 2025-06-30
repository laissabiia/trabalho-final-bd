// src/routes/escolaRoutes.js
const express = require('express');
const router = express.Router();

const escolaController = require('../controllers/escolaController');

/**
 * GET /api/escolas
 * Query params:
 *  - area: filtra escolas que tenham professores vinculados à área
 *  - professor: filtra escolas que tenham o professor específico
 */
router.get('/', escolaController.getEscolas);

module.exports = router;
