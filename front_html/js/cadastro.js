// js/cadastro.js

document.addEventListener("DOMContentLoaded", function () {
    const perfilSelect = document.getElementById("perfil");
    const alunoOrientadorCampos = document.getElementById("alunoOrientadorCampos");
    const professorCampos = document.getElementById("professorCampos");

    // Mapeamento tipos de usuário para IDs conforme back-end
    const tipoMap = {
        aluno: 1,
        orientador: 2,
        professor: 3
    };

    // Preencher instituições
    fetch(apiUrl("/api/instituicoes"))
        .then(r => r.json())
        .then(data => {
            const instituicao = document.getElementById("instituicao");
            data.forEach(item => {
                instituicao.innerHTML += `<option value="${item.id_instituicao}">${item.nome}</option>`;
            });
        });

    // Preencher cursos (atualizar conforme instituição)
    document.getElementById("instituicao").addEventListener("change", function () {
        const idInstituicao = this.value;
        const curso = document.getElementById("curso");
        curso.innerHTML = '<option value="">Selecione o curso</option>';
        if (!idInstituicao) return;
        fetch(apiUrl(`/api/cursos?instituicao=${idInstituicao}`))
            .then(r => r.json())
            .then(data => {
                data.forEach(item => {
                    curso.innerHTML += `<option value="${item.id_curso}">${item.nome}</option>`;
                });
            });
    });

    // Preencher escolas
    fetch(apiUrl("/api/escolas"))
        .then(r => r.json())
        .then(data => {
            const escola = document.getElementById("escola");
            data.forEach(item => {
                escola.innerHTML += `<option value="${item.id_escola}">${item.nome}</option>`;
            });
        });

    // Preencher áreas (atualizar conforme escola)
    document.getElementById("escola").addEventListener("change", function () {
        const idEscola = this.value;
        const area = document.getElementById("area");
        area.innerHTML = '<option value="">Selecione a área</option>';
        if (!idEscola) return;
        fetch(apiUrl(`/api/areas?escola=${idEscola}`))
            .then(r => r.json())
            .then(data => {
                data.forEach(item => {
                    area.innerHTML += `<option value="${item.id_area}">${item.nome}</option>`;
                });
            });
    });

    // Regras de exibição de campos conforme o perfil selecionado
    perfilSelect.addEventListener("change", function () {
        alunoOrientadorCampos.style.display = "none";
        professorCampos.style.display = "none";

        if (this.value === "aluno" || this.value === "orientador") {
            alunoOrientadorCampos.style.display = "block";
        } else if (this.value === "professor") {
            professorCampos.style.display = "block";
        }
    });

    // Cadastro (POST)
    document.getElementById("cadastroForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const nome = document.getElementById("nome").value.trim();
        const email = document.getElementById("email").value.trim();
        const senha = document.getElementById("senha").value;
        const perfil = perfilSelect.value;
        const idInstituicao = document.getElementById("instituicao").value;
        const idCurso = document.getElementById("curso").value;

        // Obtém o ID numérico do tipo de usuário
        const idTipo = tipoMap[perfil] || null;
        
        // Montagem do payload
        let payload = { nome, email, senha, id_tipo: idTipo };
        if (perfil === "aluno" || perfil === "orientador") {
            payload.id_instituicao = idInstituicao;
            payload.id_curso = idCurso;
        }
        if (perfil === "professor") {
            payload.id_escola = document.getElementById("escola").value;
            payload.id_area = document.getElementById("area").value;
        }

        fetch(apiUrl("/api/usuarios"), {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
            .then(async r => {
                if (r.ok) {
                    alert("Cadastro realizado com sucesso!");
                    window.location.href = "index.html";
                } else {
                    const erro = await r.json();
                    mostrarErro(erro.error || "Erro ao cadastrar usuário.");
                }
            })
            .catch(() => mostrarErro("Erro ao conectar com o servidor."));
    });

    function mostrarErro(msg) {
        const erroMsg = document.getElementById("erroMsg");
        erroMsg.textContent = msg;
        erroMsg.style.display = "block";
        setTimeout(() => { erroMsg.style.display = "none"; }, 5000);
    }
});
