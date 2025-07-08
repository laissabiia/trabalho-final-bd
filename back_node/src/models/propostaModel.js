// src/models/propostaModel.js

const pool = require('./db');

/**
 * Model para gerenciar propostas de estágio (tabela estagio)
 */
const PropostaModel = {
  /**
   * Cria um novo registro de estagio
   * @param {{ id_estagiario: number, id_orientador: number, id_professor: number, id_escola: number, id_area: number, id_modalidade: number, status?: string }} data
   * @returns {Promise<object>} objeto criado
   */
  async create(data) {
    const {
      id_estagiario,
      id_orientador,
      id_professor,
      id_escola,
      id_area,
      id_modalidade,
      status = 'pendente'
    } = data;

    const result = await pool.query(
      `INSERT INTO estagio
       (id_estagiario, id_orientador, id_professor, id_escola, id_area, id_modalidade, status)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING *`,
      [
        id_estagiario,
        id_orientador,
        id_professor,
        id_escola,
        id_area,
        id_modalidade,
        status
      ]
    );
    return result.rows[0];
  },

  /**
   * Lista todas as propostas relacionadas a um usuário (estagiário, professor ou orientador)
   * @param {number} idUsuario
   * @returns {Promise<object[]>}
   */
  async findByUser(idUsuario) {
    const result = await pool.query(
      `SELECT e.*,
              esc.nome    AS escola_nome,
              ar.nome     AS area_nome,
              md.nome     AS modalidade_nome,
              u_est.nome  AS estagiario_nome,
              u_prof.nome AS professor_nome,
              u_ori.nome  AS orientador_nome
         FROM estagio e
    JOIN estagiario est ON est.id_estagiario = e.id_estagiario
    JOIN usuario u_est ON u_est.id_usuario = est.id_usuario
    JOIN escola esc ON esc.id_escola = e.id_escola
    JOIN area ar ON ar.id_area = e.id_area
    JOIN modalidade md ON md.id_modalidade = e.id_modalidade
    JOIN professor p ON p.id_professor = e.id_professor
    JOIN usuario u_prof ON u_prof.id_usuario = p.id_usuario
    JOIN orientador o ON o.id_orientador = e.id_orientador
    JOIN usuario u_ori ON u_ori.id_usuario = o.id_usuario
        WHERE u_est.id_usuario  = $1
           OR u_prof.id_usuario = $1
           OR u_ori.id_usuario  = $1
     ORDER BY e.data_criacao DESC`,
      [idUsuario]
    );
    return result.rows;
  },

  /**
   * Busca um estagio por ID
   * @param {number} id
   * @returns {Promise<object>}
   */
  async findById(id) {
    const result = await pool.query(
      `SELECT * FROM estagio WHERE id_estagio = $1`,
      [id]
    );
    return result.rows[0];
  },

  /**
   * Atualiza um estagio existente
   * @param {number} id
   * @param {object} fields
   * @returns {Promise<object>}
   */
  async update(id, fields) {
    const keys = Object.keys(fields);
    if (!keys.length) return null;

    const setQuery = keys
      .map((k, i) => `${k} = $${i + 1}`)
      .join(', ');
    const values = Object.values(fields);

    const result = await pool.query(
      `UPDATE estagio
          SET ${setQuery}
        WHERE id_estagio = $${keys.length + 1}
        RETURNING *`,
      [...values, id]
    );
    return result.rows[0];
  },

  /**
   * Remove um estagio pelo ID
   * @param {number} id
   * @returns {Promise<void>}
   */
  async remove(id) {
    await pool.query(
      `DELETE FROM estagio WHERE id_estagio = $1`,
      [id]
    );
  }
};

module.exports = PropostaModel;
