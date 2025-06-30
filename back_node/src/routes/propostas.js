// src/routes/propostas.js
const express = require('express');
const multer = require('multer');
const path = require('path');
const authMiddleware = require('../middlewares/auth');
const propostaController = require('../controllers/propostaController');
const acompanhamentoController = require('../controllers/acompanhamentoController');

// Configuração de armazenamento de uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, 'uploads/'),
  filename: (req, file, cb) => cb(null, `${Date.now()}${path.extname(file.originalname)}`)
});
const upload = multer({ storage });

const router = express.Router();

// Autenticação aplicada a todas as rotas de propostas
router.use(authMiddleware);

// CRUD de propostas
router.post('/', upload.single('arquivo_pdf'), propostaController.create);
router.get('/', propostaController.findAll);
router.get('/:id', propostaController.findById);
router.delete('/:id', propostaController.remove);

// Rotas de acompanhamento de estágio
router.get('/:id/acompanhamento', acompanhamentoController.getAcompanhamento);
router.post(
  '/:id/acompanhamento',
  upload.single('arquivo_pdf'),
  acompanhamentoController.acompanhamento
);

module.exports = router;
