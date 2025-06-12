const express = require('express');
const router = express.Router();
const propostaController = require('../controllers/propostaController');
const multer = require('multer');
const authMiddleware = require('../middleware/authMiddleware');

// Configuração do multer
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // pasta local
  },
  filename: function (req, file, cb) {
    // Nome do arquivo: timestamp-original.pdf
    cb(null, Date.now() + '-' + file.originalname.replace(/\s/g, '_'));
  }
});
const upload = multer({ storage: storage });

// Todas as rotas protegidas:
router.post('/', authMiddleware, propostaController.create);
router.get('/', authMiddleware, propostaController.findAll);
router.get('/:id', authMiddleware, propostaController.findById);
router.put('/:id', authMiddleware, propostaController.update);
router.delete('/:id', authMiddleware, propostaController.remove);

// Upload de documento (PDF) associado à proposta
// Exemplo: POST /api/propostas/5/documento + form-data: file(PDF), tipo_documento
router.post('/:id/documento', authMiddleware, upload.single('file'), propostaController.uploadDocumento);

module.exports = router;