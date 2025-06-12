// src/app.js
const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads')); // servir PDFs

// Exemplo de rota simples
app.get('/', (req, res) => {
  res.send('API rodando!');
});

// Importar suas rotas de módulos
const authRoutes = require('./routes/authRoutes');
app.use('/api', authRoutes);
const usuarioRoutes = require('./routes/usuarioRoutes'); // unificado
app.use('/api/usuarios', usuarioRoutes);
const propostaRoutes = require('./routes/propostaRoutes');
app.use('/api/propostas', propostaRoutes);


const escolaRoutes = require('./routes/escolaRoutes');
const areaRoutes = require('./routes/areaRoutes');
const modalidadeRoutes = require('./routes/modalidadeRoutes');
const professorRoutes = require('./routes/professorRoutes');

const instituicaoRoutes = require('./routes/instituicaoRoutes');
app.use('/api/instituicoes', instituicaoRoutes);

app.use('/api/escolas', escolaRoutes);
app.use('/api/areas', areaRoutes);
app.use('/api/modalidades', modalidadeRoutes);
app.use('/api/professores', professorRoutes);

const cursoRoutes = require('./routes/cursoRoutes');
app.use('/api/cursos', cursoRoutes);


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});


