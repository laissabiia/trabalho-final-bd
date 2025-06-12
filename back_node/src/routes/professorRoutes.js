const express = require('express');
const router = express.Router();
const professorController = require('../controllers/professorController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', professorController.findAll);


module.exports = router;
