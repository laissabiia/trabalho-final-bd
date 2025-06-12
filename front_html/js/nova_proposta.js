// js/nova_proposta.js

document.addEventListener("DOMContentLoaded", function() {
    const escolaSelect = document.getElementById("escolaSelect");
    const modalidadeSelect = document.getElementById("modalidadeSelect");
    const areaSelect = document.getElementById("areaSelect");
    const professorSelect = document.getElementById("professorSelect");
    const arquivoPDF = document.getElementById("arquivoPDF");
    const enviarBtn = document.getElementById("enviarBtn");
    const labels = {
        modalidade: document.querySelector("label[for='modalidadeSelect']"),
        area: document.querySelector("label[for='areaSelect']"),
        professor: document.querySelector("label[for='professorSelect']"),
        pdf: document.querySelector("label[for='arquivoPDF']")
    };

    // Utilitário: limpar select
    function limparSelect(select) {
        select.innerHTML = '<option value="">Selecione</option>';
    }

    // Preencher escolas
    fetch(apiUrl("/api/escolas"))
        .then(r => r.json())
        .then(data => {
            data.forEach(escola => {
                escolaSelect.innerHTML += `<option value="${escola.id_escola}">${escola.nome}</option>`;
            });
        });

    // Ao selecionar escola, mostra modalidades e áreas da escola
    escolaSelect.addEventListener("change", function() {
        limparSelect(modalidadeSelect);
        limparSelect(areaSelect);
        limparSelect(professorSelect);
        labels.modalidade.style.display = "none";
        modalidadeSelect.style.display = "none";
        labels.area.style.display = "none";
        areaSelect.style.display = "none";
        labels.professor.style.display = "none";
        professorSelect.style.display = "none";
        labels.pdf.style.display = "none";
        arquivoPDF.style.display = "none";
        enviarBtn.disabled = true;

        const id_escola = escolaSelect.value;
        if (!id_escola) return;

        // Buscar modalidades da escola
        fetch(apiUrl(`/api/modalidades?escola=${id_escola}`))
            .then(r => r.json())
            .then(modalidades => {
                if (modalidades.length) {
                    labels.modalidade.style.display = "block";
                    modalidadeSelect.style.display = "block";
                    modalidades.forEach(m => {
                        modalidadeSelect.innerHTML += `<option value="${m.id_modalidade}">${m.nome}</option>`;
                    });
                }
            });

        // Buscar áreas da escola
        fetch(apiUrl(`/api/areas?escola=${id_escola}`))
            .then(r => r.json())
            .then(areas => {
                if (areas.length) {
                    labels.area.style.display = "block";
                    areaSelect.style.display = "block";
                    areas.forEach(a => {
                        areaSelect.innerHTML += `<option value="${a.id_area}">${a.nome}</option>`;
                    });
                }
            });
    });

    // Ao selecionar área, mostra professores da escola e área
    areaSelect.addEventListener("change", function() {
        limparSelect(professorSelect);
        labels.professor.style.display = "none";
        professorSelect.style.display = "none";
        labels.pdf.style.display = "none";
        arquivoPDF.style.display = "none";
        enviarBtn.disabled = true;

        const id_escola = escolaSelect.value;
        const id_area = areaSelect.value;
        if (!id_escola || !id_area) return;

        fetch(apiUrl(`/api/professores?escola=${id_escola}&area=${id_area}`))
            .then(r => r.json())
            .then(professores => {
                if (professores.length) {
                    labels.professor.style.display = "block";
                    professorSelect.style.display = "block";
                    professores.forEach(p => {
                        professorSelect.innerHTML += `<option value="${p.id_professor}">${p.nome}</option>`;
                    });
                }
            });
    });

    // Ao selecionar professor, libera PDF
    professorSelect.addEventListener("change", function() {
        if (professorSelect.value) {
            labels.pdf.style.display = "block";
            arquivoPDF.style.display = "block";
        } else {
            labels.pdf.style.display = "none";
            arquivoPDF.style.display = "none";
            enviarBtn.disabled = true;
        }
    });

    // Só libera o botão quando PDF for selecionado
    arquivoPDF.addEventListener("change", function() {
        enviarBtn.disabled = !arquivoPDF.files.length;
    });

    // Envio do formulário
    document.getElementById("novaPropostaForm").addEventListener("submit", function(e) {
        e.preventDefault();
        enviarBtn.disabled = true;

        // Validar campos obrigatórios
        if (!escolaSelect.value || !modalidadeSelect.value || !areaSelect.value || !professorSelect.value || !arquivoPDF.files.length) {
            alert("Preencha todos os campos!");
            enviarBtn.disabled = false;
            return;
        }

        const formData = new FormData();
        formData.append("id_escola", escolaSelect.value);
        formData.append("id_modalidade", modalidadeSelect.value);
        formData.append("id_area", areaSelect.value);
        formData.append("id_professor", professorSelect.value);
        formData.append("arquivo_pdf", arquivoPDF.files[0]);

        fetch(apiUrl("/api/propostas"), {
            method: "POST",
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            body: formData
        })
        .then(async response => {
            if (response.ok) {
                alert("Proposta enviada com sucesso!");
                window.location.href = "propostas.html";
            } else {
                const erro = await response.json();
                alert("Erro ao enviar proposta: " + (erro.error || "Erro desconhecido"));
            }
        })
        .catch(() => alert("Erro ao enviar proposta."))
        .finally(() => enviarBtn.disabled = false);
    });
});
