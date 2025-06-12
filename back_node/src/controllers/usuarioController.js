const UsuarioModel = require("../models/usuarioModel");
const PerfilUsuarioModel = require("../models/perfilUsuarioModel");
const bcrypt = require("bcryptjs");
const pool = require("../models/db");

const usuarioController = {
  async create(req, res) {
    const { nome, email, senha, tipos } = req.body; // tipos = array de id_tipo
    try {
      const senhaHash = await bcrypt.hash(senha, 10); // hash da senha
      const usuario = await UsuarioModel.create(nome, email, senhaHash);

      // Vincula os perfis, se enviados
      if (tipos && Array.isArray(tipos) && tipos.length > 0) {
        for (const id_tipo of tipos) {
          await PerfilUsuarioModel.addTipoAoUsuario(
            usuario.id_usuario,
            id_tipo
          );
        }
      }

      // Se o perfil de aluno (estagiário) for selecionado, cadastra também em estagiario
      if (tipos && tipos.includes(1)) {
        const id_instituicao = req.body.id_instituicao || 1;
        const id_curso = req.body.id_curso || 1;
        await pool.query(
          "INSERT INTO estagiario (id_usuario, id_curso, id_instituicao) VALUES ($1, $2, $3)",
          [usuario.id_usuario, id_curso, id_instituicao]
        );
      }

      // SE foi selecionado perfil de professor, insere na tabela professor
      if (tipos && tipos.includes(2)) {
        const id_instituicao = req.body.id_instituicao || 1; // 1 = fallback, mas use o do body
        await pool.query(
          "INSERT INTO professor (id_usuario, id_instituicao) VALUES ($1, $2)",
          [usuario.id_usuario, id_instituicao]
        );
      }

      // Retorna o usuário criado e os tipos vinculados
      const perfis = tipos
        ? await PerfilUsuarioModel.getTiposDoUsuario(usuario.id_usuario)
        : [];
      res.status(201).json({ ...usuario, perfis });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  },

  async findAll(req, res) {
    try {
      const usuarios = await UsuarioModel.findAll();
      // Para cada usuário, busca os perfis
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

  async update(req, res) {
    const { id } = req.params;
    const { nome, email, senha, tipos } = req.body; // tipos = array de id_tipo

    try {
      // Atualiza dados básicos
      const usuario = await UsuarioModel.update(id, nome, email, senha);
      if (!usuario) {
        return res.status(404).json({ error: "Usuário não encontrado" });
      }

      // Atualiza perfis se enviado o array tipos
      if (tipos && Array.isArray(tipos)) {
        // Remove todos os perfis antigos
        const perfisAtuais = await PerfilUsuarioModel.getTiposDoUsuario(id);
        for (const perfil of perfisAtuais) {
          await PerfilUsuarioModel.removeTipoDoUsuario(id, perfil.id_tipo);
        }
        // Adiciona os perfis novos
        for (const id_tipo of tipos) {
          await PerfilUsuarioModel.addTipoAoUsuario(id, id_tipo);
        }
      }

      // Busca perfis finais
      const perfis = await PerfilUsuarioModel.getTiposDoUsuario(id);
      res.json({ ...usuario, perfis });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  },

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
