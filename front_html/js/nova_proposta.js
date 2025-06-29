// js/nova_proposta.js

document.addEventListener('DOMContentLoaded', async () => {
  const token = localStorage.getItem('token');
  if (!token) return window.location.href = 'index.html';
  const headers = { 'Authorization': 'Bearer ' + token };

  // Elementos de fluxo
  const radioGroup = document.getElementsByName('modoBusca');
  const fluxoEscola = document.getElementById('fluxoEscola');
  const fluxoArea = document.getElementById('fluxoArea');

  // Selects
  const selEscola = document.getElementById('selectEscola');
  const selAreaEscola = document.getElementById('selectAreaEscola');
  const selModEscola = document.getElementById('selectModalidadeEscola');
  const selArea = document.getElementById('selectArea');
  const selEscolaArea = document.getElementById('selectEscolaArea');
  const selModArea = document.getElementById('selectModalidadeArea');

  // Carrega escolas e áreas iniciais
  const escolas = await fetch(apiUrl('/api/escolas'), { headers }).then(r => r.json());
  escolas.forEach(e => selEscola.append(new Option(e.nome, e.id_escola)));
  selEscolaArea.append(...selEscola.options);

  const areas = await fetch(apiUrl('/api/areas'), { headers }).then(r => r.json());
  areas.forEach(a => selArea.append(new Option(a.nome, a.id_area)));

  // Muda entre fluxos
  radioGroup.forEach(rb => rb.addEventListener('change', () => {
    if (rb.checked) {
      if (rb.value === 'escola') {
        fluxoEscola.style.display = '';
        fluxoArea.style.display = 'none';
      } else {
        fluxoEscola.style.display = 'none';
        fluxoArea.style.display = '';
      }
    }
  }));

  // Fluxo Escola → Área/Modalidade
  selEscola.addEventListener('change', async () => {
    const id = selEscola.value;
    selAreaEscola.innerHTML = '<option value="">Selecione a área</option>';
    selModEscola.innerHTML = '<option value="">Selecione a modalidade</option>';
    if (!id) return;
    const [areasEsc, modEsc] = await Promise.all([
      fetch(apiUrl(`/api/areas?escola=${id}`), { headers }).then(r => r.json()),
      fetch(apiUrl(`/api/modalidades?escola=${id}`), { headers }).then(r => r.json())
    ]);
    areasEsc.forEach(a => selAreaEscola.append(new Option(a.nome, a.id_area)));
    modEsc.forEach(m => selModEscola.append(new Option(m.nome, m.id_modalidade)));
  });

  // Fluxo Área → Escola/Modalidade
  selArea.addEventListener('change', async () => {
    const id = selArea.value;
    selEscolaArea.innerHTML = '<option value="">Selecione a escola</option>';
    selModArea.innerHTML = '<option value="">Selecione a modalidade</option>';
    if (!id) return;
    const escolasArea = await fetch(apiUrl(`/api/escolas?area=${id}`), { headers }).then(r => r.json());
    escolasArea.forEach(e => selEscolaArea.append(new Option(e.nome, e.id_escola)));
  });

  selEscolaArea.addEventListener('change', async () => {
    const id = selEscolaArea.value;
    selModArea.innerHTML = '<option value="">Selecione a modalidade</option>';
    if (!id) return;
    const modEsc = await fetch(apiUrl(`/api/modalidades?escola=${id}`), { headers }).then(r => r.json());
    modEsc.forEach(m => selModArea.append(new Option(m.nome, m.id_modalidade)));
  });

  // Envio
  document.getElementById('btnEnviarNova').addEventListener('click', async () => {
    const erroEl = document.getElementById('erroNova');
    erroEl.style.display = 'none';

    const modo = [...radioGroup].find(rb => rb.checked).value;
    let idEscolaVal, idAreaVal, idModVal;
    if (modo === 'escola') {
      idEscolaVal = selEscola.value;
      idAreaVal = selAreaEscola.value;
      idModVal = selModEscola.value;
    } else {
      idAreaVal = selArea.value;
      idEscolaVal = selEscolaArea.value;
      idModVal = selModArea.value;
    }
    if (!idEscolaVal || !idAreaVal || !idModVal) {
      erroEl.textContent = 'Preencha todos os campos do fluxo selecionado.';
      erroEl.style.display = 'block';
      return;
    }

    // Prepara FormData para upload de PDF
    const formData = new FormData();
    formData.append('id_escola', idEscolaVal);
    formData.append('id_area', idAreaVal);
    formData.append('id_modalidade', idModVal);
    const arquivo = document.getElementById('arquivoPDF');
    if (!arquivo.files.length) {
      erroEl.textContent = 'Selecione o arquivo PDF.';
      erroEl.style.display = 'block';
      return;
    }
    formData.append('arquivo_pdf', arquivo.files[0]);

    // Chamada via fetch deixando Content-Type para o browser
    try {
      const resp = await fetch(apiUrl('/api/propostas'), {
        method: 'POST',
        headers: { 'Authorization': 'Bearer ' + token },
        body: formData
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

  // Cancelar volta para proposta
  document.getElementById('btnCancelarNova').addEventListener('click', () => {
    window.location.href = 'propostas.html';
  });
});
