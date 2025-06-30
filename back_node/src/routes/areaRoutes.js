// src/routes/areaRoutes.js
const express = require('express');
const router = express.Router();

const areaController = require('../controllers/areaController');

/**
 * GET /api/areas
 * Query params:
 *  - escola: filtra áreas que tenham professores vinculados àquela escola
 */
router.get('/', areaController.getAreas);

module.exports = router;