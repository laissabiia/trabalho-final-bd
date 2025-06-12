const express = require('express');
const router = express.Router();
const areaController = require('../controllers/areaController');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/', areaController.findAll);


module.exports = router;
