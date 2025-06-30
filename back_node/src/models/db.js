require('dotenv').config();
const { Pool } = require('pg');

// conexão via variáveis de ambiente
const pool = new Pool({
  user:     process.env.DB_USER,     // ex: 'postgres'
  host:     process.env.DB_HOST,     // ex: 'localhost' ou IP do server
  database: process.env.DB_NAME,     // ex: 'siesu'
  password: process.env.DB_PASSWORD, // ex: 'sua_senha_aqui'
  port:     process.env.DB_PORT,     // ex: 5432
});

module.exports = pool;
