require("dotenv").config();
const { Pool } = require("pg");

// Log environment variables to verify DB connection
console.log("[DB] Environment:", {
  DB_HOST: process.env.DB_HOST,
  DB_PORT: process.env.DB_PORT,
  DB_NAME: process.env.DB_NAME,
  DB_USER: process.env.DB_USER,
});
// conexão via variáveis de ambiente
const pool = new Pool({
  user: process.env.DB_USER, // ex: 'postgres'
  host: process.env.DB_HOST, // ex: 'localhost' ou IP do server
  database: process.env.DB_NAME, // ex: 'siesu'
  password: process.env.DB_PASSWORD, // ex: 'sua_senha_aqui'
  port: process.env.DB_PORT, // ex: 5432
});

// After a client connects, log the actual database name
pool.on("connect", (client) => {
  client
    .query("SELECT current_database()")
    .then((res) =>
      console.log("[DB] Connected to database:", res.rows[0].current_database)
    )
    .catch((err) =>
      console.error("[DB] Unable to fetch current database:", err)
    );
});

module.exports = pool;
