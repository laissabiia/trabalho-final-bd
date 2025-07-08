// src/controllers/documentoEstagioController.js

const DocumentoEstagioModel = require('../models/documentoEstagioModel');
const pool = require('../models/db');

const documentoEstagioController = {
  /**
   * Retorna o PDF armazenado em bytea no banco, para download/visualização.
   */
  async getPDF(req, res) {
    try {
      const idDocumento = parseInt(req.params.id, 10);
      if (isNaN(idDocumento)) {
        return res.status(400).json({ error: 'ID de documento inválido.' });
      }

      // Busca o documento (inclui arquivo_pdf como Buffer)
      const doc = await DocumentoEstagioModel.findById(idDocumento);
      if (!doc) {
        return res.status(404).json({ error: 'Documento não encontrado.' });
      }

      // Define cabeçalhos para PDF
      res.set({
        'Content-Type': 'application/pdf',
        'Content-Disposition': `attachment; filename="documento_${idDocumento}.pdf"`
      });

      // Envia o buffer diretamente
      return res.send(doc.arquivo_pdf);
    } catch (error) {
      console.error('[documentoEstagioController.getPDF] Erro:', error);
      return res.status(500).json({ error: 'Falha ao recuperar PDF.' });
    }
  }
};

module.exports = documentoEstagioController;
