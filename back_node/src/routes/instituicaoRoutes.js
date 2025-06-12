const express = require('express');
const router = express.Router();
const instituicaoController = require('../controllers/instituicaoController');

router.get('/', instituicaoController.findAll); // GET /api/instituicoes

module.exports = router;
