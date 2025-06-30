// src/app.js
const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads')); // servir PDFs

// Rotas de autenticação e usuários
const authRoutes = require('./routes/authRoutes');
app.use('/api', authRoutes);
const usuarioRoutes = require('./routes/usuarioRoutes');
app.use('/api/usuarios', usuarioRoutes);

// Rotas de domínio
const escolaRoutes = require('./routes/escolaRoutes');
const areaRoutes = require('./routes/areaRoutes');
const modalidadeRoutes = require('./routes/modalidadeRoutes');
const professorRoutes = require('./routes/professorRoutes');
const orientadorRoutes = require('./routes/orientadorRoutes');
const instituicaoRoutes = require('./routes/instituicaoRoutes');
const cursoRoutes = require('./routes/cursoRoutes');
const propostaRoutes = require('./routes/propostaRoutes');

app.use('/api/instituicoes', instituicaoRoutes);
app.use('/api/escolas', escolaRoutes);
app.use('/api/areas', areaRoutes);
app.use('/api/modalidades', modalidadeRoutes);
app.use('/api/professores', professorRoutes);
app.use('/api/orientadores', orientadorRoutes);
app.use('/api/cursos', cursoRoutes);
app.use('/api/propostas', propostaRoutes);

// Health check
app.get('/', (req, res) => {
  res.send('API rodando!');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
