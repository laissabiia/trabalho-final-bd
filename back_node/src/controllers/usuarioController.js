// src/controllers/usuarioController.js
const UsuarioModel = require("../models/usuarioModel");
const PerfilUsuarioModel = require("../models/perfilUsuarioModel");
const bcrypt = require("bcryptjs");
const pool = require("../models/db");

const usuarioController = {
  // Cria um novo usuário
  async create(req, res) {
    console.log("[usuarioController.create] Payload recebido:", req.body);

    // Campos básicos
    const { nome, email, senha } = req.body;
    // Converte id_tipo para número
    const id_tipo = req.body.id_tipo ? parseInt(req.body.id_tipo, 10) : null;
    // Converte o array de tipos (caso venha) ou cria array com id_tipo único
    const tiposArray = Array.isArray(req.body.tipos)
      ? req.body.tipos.map((t) => parseInt(t, 10))
      : id_tipo
      ? [id_tipo]
      : [];
    console.log("[usuarioController.create] tiposArray resultante:", tiposArray);

    // Converte demais IDs para número (ou null se não vier)
    const id_curso = req.body.id_curso ? parseInt(req.body.id_curso, 10) : null;
    const id_instituicao = req.body.id_instituicao
      ? parseInt(req.body.id_instituicao, 10)
      : null;
    const id_escola = req.body.id_escola
      ? parseInt(req.body.id_escola, 10)
      : null;
    const id_area = req.body.id_area ? parseInt(req.body.id_area, 10) : null;

    try {
      const senhaHash = await bcrypt.hash(senha, 10);
      // Cria usuário incluindo id_tipo
      const usuario = await UsuarioModel.create(
        nome,
        email,
        senhaHash,
        id_tipo
      );

      // Vincula perfis ao usuário
      for (const tipoId of tiposArray) {
        await PerfilUsuarioModel.addTipoAoUsuario(
          usuario.id_usuario,
          tipoId
        );
      }

      // Perfil ALUNO => insere em estagiario
      if (tiposArray.includes(1)) {
        if (id_curso == null || id_instituicao == null) {
          return res
            .status(400)
            .json({
              error:
                "id_curso e id_instituicao são obrigatórios para perfil aluno.",
            });
        }
        await pool.query(
          "INSERT INTO estagiario (id_usuario, id_curso, id_instituicao) VALUES ($1, $2, $3)",
          [usuario.id_usuario, id_curso, id_instituicao]
        );
      }

      // Perfil PROFESSOR => insere em professor e professor_area
      if (tiposArray.includes(2)) {
        if (id_escola == null || id_area == null) {
          return res
            .status(400)
            .json({
              error:
                "id_escola e id_area são obrigatórios para perfil professor.",
            });
        }
        const resProfessor = await pool.query(
          "INSERT INTO professor (id_usuario, id_escola) VALUES ($1, $2) RETURNING id_professor",
          [usuario.id_usuario, id_escola]
        );
        const idProfessor = resProfessor.rows[0].id_professor;
        await pool.query(
          "INSERT INTO professor_area (id_professor, id_area) VALUES ($1, $2)",
          [idProfessor, id_area]
        );
      }

      // Perfil ORIENTADOR => insere em orientador
      if (tiposArray.includes(3)) {
        if (id_instituicao == null) {
          return res
            .status(400)
            .json({
              error:
                "id_instituicao é obrigatório para perfil orientador.",
            });
        }
        await pool.query(
          "INSERT INTO orientador (id_usuario, id_instituicao) VALUES ($1, $2)",
          [usuario.id_usuario, id_instituicao]
        );
      }

      // Retorna usuário criado e perfis
      const perfis = tiposArray.length
        ? await PerfilUsuarioModel.getTiposDoUsuario(usuario.id_usuario)
        : [];
      return res.status(201).json({ ...usuario, perfis });
    } catch (error) {
      console.error(
        "[usuarioController.create] Erro ao criar usuário:",
        error
      );
      return res.status(400).json({ error: error.message });
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

    /**
   * GET /api/usuarios/:id/perfil
   * Retorna os perfis de estagiário e de orientador vinculados ao usuário.
   */
  async getPerfil(req, res) {
    try {
      const id_usuario = parseInt(req.params.id, 10);

      // Busca estagiário e instituição
      const estRes = await pool.query(
        'SELECT id_estagiario, id_instituicao FROM estagiario WHERE id_usuario = $1',
        [id_usuario]
      );
      const estagiario = estRes.rows[0] || null;

      // Busca orientador e instituição
      const oriRes = await pool.query(
        'SELECT id_orientador, id_instituicao FROM orientador WHERE id_usuario = $1',
        [id_usuario]
      );
      const orientador = oriRes.rows[0] || null;

      return res.json({
        id_usuario,
        estagiario,
        orientador
      });
    } catch (error) {
      console.error('[usuarioController.getPerfil] Erro ao buscar perfil:', error);
      return res.status(500).json({ error: error.message });
    }
  }
};

module.exports = usuarioController;
