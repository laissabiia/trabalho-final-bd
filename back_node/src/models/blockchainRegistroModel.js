const pool = require('./db');

const BlockchainRegistroModel = {
  async create({ id_proposta, id_documento, tipo_evento, hash_blockchain }) {
    const result = await pool.query(
      `INSERT INTO blockchain_registro 
      (id_proposta, id_documento, tipo_evento, hash_blockchain) 
      VALUES ($1, $2, $3, $4) RETURNING *`,
      [id_proposta, id_documento, tipo_evento, hash_blockchain]
    );
    return result.rows[0];
  }
};

module.exports = BlockchainRegistroModel;
