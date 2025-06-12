const express = require('express');
const router = express.Router();
const modalidadeController = require('../controllers/modalidadeController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', modalidadeController.findAll);


module.exports = router;
