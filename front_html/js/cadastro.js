// js/cadastro.js

document.addEventListener("DOMContentLoaded", function () {
    const perfilSelect = document.getElementById("perfil");
    const alunoOrientadorCampos = document.getElementById("alunoOrientadorCampos");
    const professorCampos = document.getElementById("professorCampos");

    // Mapeamento tipos de usuário para IDs conforme back-end
    const tipoMap = {
        aluno: 1,
        orientador: 3,
        professor: 2
    };

    // Função auxiliar para popular selects
    function populateSelect(selectEl, items, valueKey, textKey) {
        selectEl.innerHTML = `<option value="">Selecione</option>`;
        items.forEach(item => {
            const opt = document.createElement('option');
            opt.value = item[valueKey];
            opt.textContent = item[textKey];
            selectEl.appendChild(opt);
        });
    }

    // Fetch inicial de instituições e cursos
    fetch(apiUrl("/api/instituicoes")).then(r => r.json()).then(data => {
        populateSelect(document.getElementById("instituicao"), data, 'id_instituicao', 'nome');
    });

    document.getElementById("instituicao").addEventListener("change", function () {
        const idInstituicao = this.value;
        const curso = document.getElementById("curso");
        curso.innerHTML = '<option value="">Selecione o curso</option>';
        if (!idInstituicao) return;
        fetch(apiUrl(`/api/cursos?instituicao=${idInstituicao}`))
            .then(r => r.json())
            .then(data => populateSelect(curso, data, 'id_curso', 'nome'));
    });

    // Fetch completo de escolas e áreas (sem filtros) para cadastro de professor
    fetch(apiUrl("/api/escolas")).then(r => r.json()).then(data => {
        populateSelect(document.getElementById("escola"), data, 'id_escola', 'nome');
    });
    fetch(apiUrl("/api/areas")).then(r => r.json()).then(data => {
        populateSelect(document.getElementById("area"), data, 'id_area', 'nome');
    });

    // Regras de exibição de campos conforme perfil selecionado
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
        const idTipo = tipoMap[perfil] || null;

        let payload = { nome, email, senha, id_tipo: idTipo };
        if (perfil === "aluno" || perfil === "orientador") {
            payload.id_instituicao = document.getElementById("instituicao").value;
            payload.id_curso = document.getElementById("curso").value;
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
