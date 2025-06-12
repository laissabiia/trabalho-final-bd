const express = require('express');
const router = express.Router();
const pool = require('../models/db');

// GET /api/cursos?instituicao=ID
router.get('/', async (req, res) => {
  try {
    const { instituicao } = req.query;
    let query = 'SELECT id_curso, nome FROM curso';
    let params = [];
    if (instituicao) {
      query += ' WHERE id_instituicao = $1';
      params.push(Number(instituicao));
    }
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
