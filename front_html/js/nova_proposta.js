// js/nova_proposta.js

/**
 * Lógica para criação de nova proposta de estágio,
 * usando GET /api/usuarios/:id/perfil para obter vinculações
 * e filtragem de Professor (escola+área) e Orientador (instituição).
 */
document.addEventListener('DOMContentLoaded', () => {
  const token = localStorage.getItem('token');
  if (!token) {
    window.location.href = 'index.html';
    return;
  }
  const headers = { 'Authorization': 'Bearer ' + token };

  // Decodifica token para obter userId
  const payload = JSON.parse(atob(token.split('.')[1]));
  const userId = payload.id;
  let idInstituicao;

  // DOM elements
  const selOrientador = document.getElementById('selectOrientador');
  const selProfessor = document.getElementById('selectProfessor');
  const selEscola = document.getElementById('selectEscola');
  const selAreaEscola = document.getElementById('selectAreaEscola');
  const selModEscola = document.getElementById('selectModalidadeEscola');
  const selArea = document.getElementById('selectArea');
  const selEscolaArea = document.getElementById('selectEscolaArea');
  const selModArea = document.getElementById('selectModalidadeArea');
  const arquivoPDF = document.getElementById('arquivoPDF');
  const btnEnviar = document.getElementById('btnEnviarNova');
  const btnCancelar = document.getElementById('btnCancelarNova');
  const erroEl = document.getElementById('erroNova');
  const radioGroup = Array.from(document.getElementsByName('modoBusca'));
  const fluxoEscola = document.getElementById('fluxoEscola');
  const fluxoArea = document.getElementById('fluxoArea');

  // Inicialização: busca perfil do usuário consolidado
  (async () => {
    try {
      // Substitui /api/estagiarios por /api/usuarios/:id/perfil
      const perfilRes = await fetch(apiUrl(`/api/usuarios/${userId}/perfil`), { headers });
      if (!perfilRes.ok) throw new Error('Perfil não encontrado');
      const perfil = await perfilRes.json();
      if (!perfil.estagiario) throw new Error('Usuário não é estagiário');
      idInstituicao = perfil.estagiario.id_instituicao;

      // Carrega orientadores (supervisores institucionais)
      const oriRes = await fetch(apiUrl(`/api/orientadores?instituicao=${idInstituicao}`), { headers });
      selOrientador.innerHTML = '<option value="">Selecione o orientador</option>';
      if (oriRes.ok) {
        const orientadores = await oriRes.json();
        orientadores.forEach(o => selOrientador.append(new Option(o.nome, o.id_orientador)));
      }

      // Carrega escolas e áreas iniciais
      const [escolas, areas] = await Promise.all([
        fetch(apiUrl('/api/escolas'), { headers }).then(r => r.json()),
        fetch(apiUrl('/api/areas'), { headers }).then(r => r.json())
      ]);
      selEscola.innerHTML = '<option value="">Selecione a escola</option>';
      selEscolaArea.innerHTML = '<option value="">Selecione a escola</option>';
      escolas.forEach(e => {
        selEscola.append(new Option(e.nome, e.id_escola));
        selEscolaArea.append(new Option(e.nome, e.id_escola));
      });
      selArea.innerHTML = '<option value="">Selecione a área</option>';
      areas.forEach(a => selArea.append(new Option(a.nome, a.id_area)));
    } catch (e) {
      console.error('[nova_proposta.js] erro init:', e);
      erroEl.textContent = 'Erro ao carregar perfil ou dados iniciais.';
      erroEl.style.display = 'block';
    }
  })();

  // Alterna fluxos
  radioGroup.forEach(rb => rb.addEventListener('change', () => {
    fluxoEscola.style.display = rb.value === 'escola' ? '' : 'none';
    fluxoArea.style.display = rb.value === 'area' ? '' : 'none';
    selProfessor.innerHTML = '<option value="">Selecione o professor</option>';
  }));

  // Fluxo Escola → Área/Modalidade
  selEscola.addEventListener('change', async () => {
    selAreaEscola.innerHTML = '<option value="">Selecione a área</option>';
    selModEscola.innerHTML = '<option value="">Selecione a modalidade</option>';
    selProfessor.innerHTML = '<option value="">Selecione o professor</option>';
    const idEsc = selEscola.value;
    if (!idEsc) return;
    try {
      const [areasEsc, modEsc] = await Promise.all([
        fetch(apiUrl(`/api/areas?escola=${idEsc}`), { headers }).then(r => r.json()),
        fetch(apiUrl(`/api/modalidades?escola=${idEsc}`), { headers }).then(r => r.json())
      ]);
      areasEsc.forEach(a => selAreaEscola.append(new Option(a.nome, a.id_area)));
      modEsc.forEach(m => selModEscola.append(new Option(m.nome, m.id_modalidade)));
    } catch (e) {
      console.error('[nova_proposta.js] erro fluxo escola:', e);
    }
  });

  // Fluxo Área → Escola/Modalidade
  selArea.addEventListener('change', async () => {
    selEscolaArea.innerHTML = '<option value="">Selecione a escola</option>';
    selModArea.innerHTML = '<option value="">Selecione a modalidade</option>';
    selProfessor.innerHTML = '<option value="">Selecione o professor</option>';
    const idArea = selArea.value;
    if (!idArea) return;
    try {
      const escolasArea = await fetch(apiUrl(`/api/escolas?area=${idArea}`), { headers }).then(r => r.json());
      escolasArea.forEach(e => selEscolaArea.append(new Option(e.nome, e.id_escola)));
    } catch (e) {
      console.error('[nova_proposta.js] erro fluxo area:', e);
    }
  });

  // Quando escola/area/fluxo mudam, busca professores
  selAreaEscola.addEventListener('change', fetchProfessores);
  selModEscola.addEventListener('change', fetchProfessores);
  selEscolaArea.addEventListener('change', async () => {
    selModArea.innerHTML = '<option value="">Selecione a modalidade</option>';
    selProfessor.innerHTML = '<option value="">Selecione o professor</option>';
    const idEsc = selEscolaArea.value;
    if (!idEsc) return;
    try {
      const modEsc = await fetch(apiUrl(`/api/modalidades?escola=${idEsc}`), { headers }).then(r => r.json());
      modEsc.forEach(m => selModArea.append(new Option(m.nome, m.id_modalidade)));
    } catch (e) {
      console.error('[nova_proposta.js] erro fluxo area escola:', e);
    }
  });
  selModArea.addEventListener('change', fetchProfessores);

  async function fetchProfessores() {
    selProfessor.innerHTML = '<option value="">Selecione o professor</option>';
    const modo = radioGroup.find(rb => rb.checked).value;
    const idEsc = modo === 'escola' ? selEscola.value : selEscolaArea.value;
    const idArea = modo === 'escola' ? selAreaEscola.value : selArea.value;
    if (!idEsc || !idArea) return;
    try {
      const professores = await fetch(
        apiUrl(`/api/professores?escola=${idEsc}&area=${idArea}`), { headers }
      ).then(r => r.json());
      professores.forEach(p => selProfessor.append(new Option(p.nome, p.id_professor)));
    } catch (e) {
      console.error('[nova_proposta.js] erro fetch professores:', e);
    }
  }

  // Envio do formulário
  btnEnviar.addEventListener('click', async () => {
    erroEl.style.display = 'none';
    const modo = radioGroup.find(rb => rb.checked).value;
    const idEsc = modo === 'escola' ? selEscola.value : selEscolaArea.value;
    const idAreaVal = modo === 'escola' ? selAreaEscola.value : selArea.value;
    const idMod = modo === 'escola' ? selModEscola.value : selModArea.value;
    const idProf = selProfessor.value;
    const idOri = selOrientador.value;
    if (!idOri || !idProf || !idEsc || !idAreaVal || !idMod) {
      erroEl.textContent = 'Preencha todos os campos.';
      erroEl.style.display = 'block';
      return;
    }
    if (!arquivoPDF.files.length) {
      erroEl.textContent = 'Selecione o PDF.';
      erroEl.style.display = 'block';
      return;
    }
    const formData = new FormData();
    formData.append('id_orientador', idOri);
    formData.append('id_professor', idProf);
    formData.append('id_escola', idEsc);
    formData.append('id_area', idAreaVal);
    formData.append('id_modalidade', idMod);
    formData.append('arquivo_pdf', arquivoPDF.files[0]);

    try {
      const resp = await fetch(apiUrl('/api/propostas'), {
        method: 'POST', headers, body: formData
      });
      const data = await resp.json();
      if (!resp.ok) throw new Error(data.error || 'Erro ao enviar proposta.');
      alert('Proposta enviada com sucesso!');
      window.location.href = 'propostas.html';
    } catch (e) {
      console.error('[nova_proposta.js] erro ao enviar proposta:', e);
      erroEl.textContent = e.message;
      erroEl.style.display = 'block';
    }
  });

  btnCancelar.addEventListener('click', () => window.location.href = 'propostas.html');
});
