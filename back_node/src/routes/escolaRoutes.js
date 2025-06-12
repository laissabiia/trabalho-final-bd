const express = require('express');
const router = express.Router();
const escolaController = require('../controllers/escolaController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', escolaController.findAll); // Remova o authMiddleware do GET!

module.exports = router;
