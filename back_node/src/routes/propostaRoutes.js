// src/routes/propostaRoutes.js

const express = require('express');
const multer = require('multer');
const propostaController = require('../controllers/propostaController');
const acompanhamentoController = require('../controllers/acompanhamentoController');
const documentoEstagioController = require('../controllers/documentoEstagioController');
const authMiddleware = require('../middleware/authMiddleware');

// Configura Multer para armazenar arquivos em memória (buffer)
const storage = multer.memoryStorage();
const upload = multer({ storage });

const router = express.Router();

// Aplica autenticação a todas as rotas de propostas
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

// Rota para download do PDF armazenado em bytea no DB
router.get('/documentos/:id/pdf', documentoEstagioController.getPDF);

module.exports = router;
