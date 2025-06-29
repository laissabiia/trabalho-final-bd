// src/controllers/usuarioController.js
console.log("[usuarioController] Módulo carregado");
const UsuarioModel = require("../models/usuarioModel");
const PerfilUsuarioModel = require("../models/perfilUsuarioModel");
const bcrypt = require("bcryptjs");
const pool = require("../models/db");

const usuarioController = {
  // Cria um novo usuário
  async create(req, res) {
    console.log("[usuarioController.create] Payload recebido:", req.body);
    const { nome, email, senha, tipos, id_tipo, id_instituicao, id_curso, id_escola, id_area } = req.body;
    let tiposArray = [];
    if (Array.isArray(tipos)) {
      tiposArray = tipos.slice();
    } else if (id_tipo) {
      tiposArray = [id_tipo];
    }
    console.log("[usuarioController.create] tiposArray resultante:", tiposArray);

    try {
      const senhaHash = await bcrypt.hash(senha, 10);
      // Inclui id_tipo na criação do usuario
      const usuario = await UsuarioModel.create(nome, email, senhaHash, id_tipo);

      // Vincula perfis ao usuário
      for (const tipoId of tiposArray) {
        await PerfilUsuarioModel.addTipoAoUsuario(usuario.id_usuario, tipoId);
      }

      // Inserção em estagiario (perfil aluno)
      if (tiposArray.includes(1)) {
        await pool.query(
          "INSERT INTO estagiario (id_usuario, id_curso, id_instituicao) VALUES ($1, $2, $3)",
          [usuario.id_usuario, id_curso, id_instituicao]
        );
      }

      // Inserção em professor e vínculo de área (perfil professor)
      if (tiposArray.includes(3)) {
        // Primeiro cria o registro de professor
        const resProfessor = await pool.query(
          "INSERT INTO professor (id_usuario, id_escola) VALUES ($1, $2) RETURNING id_professor",
          [usuario.id_usuario, id_escola]
        );
        const idProfessor = resProfessor.rows[0].id_professor;
        // Em seguida, vincula a área na tabela de relacionamento
        if (id_area) {
          await pool.query(
            "INSERT INTO professor_area (id_professor, id_area) VALUES ($1, $2)",
            [idProfessor, id_area]
          );
        }
      }

      const perfis = tiposArray.length
        ? await PerfilUsuarioModel.getTiposDoUsuario(usuario.id_usuario)
        : [];
      res.status(201).json({ ...usuario, perfis });
    } catch (error) {
      console.error("[usuarioController.create] Erro ao criar usuário:", error);
      res.status(400).json({ error: error.message });
    }
  },

  // Lista todos os usuários com seus perfis
  async findAll(req, res) {
    try {
      const usuarios = await UsuarioModel.findAll();
      const usuariosComPerfis = await Promise.all(
        usuarios.map(async (usuario) => {
          const perfis = await PerfilUsuarioModel.getTiposDoUsuario(
            usuario.id_usuario
          );
          return { ...usuario, perfis };
        })
      );
      res.json(usuariosComPerfis);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Busca um usuário por ID (com perfis)
  async findById(req, res) {
    try {
      const usuario = await UsuarioModel.findById(req.params.id);
      if (!usuario) {
        return res.status(404).json({ error: "Usuário não encontrado" });
      }
      const perfis = await PerfilUsuarioModel.getTiposDoUsuario(
        usuario.id_usuario
      );
      res.json({ ...usuario, perfis });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Atualiza dados e perfis de um usuário
  async update(req, res) {
    const { id } = req.params;
    const { nome, email, senha, tipos, id_tipo } = req.body;
    let tiposArray = Array.isArray(tipos) ? tipos.slice() : [];
    if (!Array.isArray(tiposArray) && id_tipo) {
      tiposArray = [id_tipo];
    }

    try {
      const usuario = await UsuarioModel.update(id, nome, email, senha);
      if (!usuario) {
        return res.status(404).json({ error: "Usuário não encontrado" });
      }

      // atualiza perfis: remove antigos e insere novos
      if (tiposArray.length > 0) {
        const perfisAtuais = await PerfilUsuarioModel.getTiposDoUsuario(id);
        for (const perfil of perfisAtuais) {
          await PerfilUsuarioModel.removeTipoDoUsuario(id, perfil.id_tipo);
        }
        for (const tipoId of tiposArray) {
          await PerfilUsuarioModel.addTipoAoUsuario(id, tipoId);
        }
      }

      const perfis = await PerfilUsuarioModel.getTiposDoUsuario(id);
      res.json({ ...usuario, perfis });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  },

  // Remove um usuário
  async remove(req, res) {
    const { id } = req.params;
    try {
      await UsuarioModel.remove(id);
      res.json({ message: "Usuário removido com sucesso" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = usuarioController;
