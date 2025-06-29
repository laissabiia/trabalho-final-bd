// js/propostas.js
console.log('[propostas.js] script loaded');

document.addEventListener('DOMContentLoaded', async () => {
  // Valida token
  const token = localStorage.getItem('token');
  if (!token) {
    window.location.href = 'index.html';
    return;
  }
  const headers = { 'Authorization': 'Bearer ' + token };

  // Decodifica payload JWT
  let payload;
  try {
    payload = JSON.parse(atob(token.split('.')[1]));
  } catch (e) {
    console.error('[propostas.js] Falha ao decodificar token', e);
    localStorage.removeItem('token');
    window.location.href = 'index.html';
    return;
  }
  const userId = payload.id;

  // Obtém perfis do usuário
  let tiposUsuario;
  try {
    const resTipos = await fetch(apiUrl(`/api/usuarios/${userId}/tipos`), { headers });
    if (!resTipos.ok) throw new Error('Erro ao carregar perfis');
    tiposUsuario = await resTipos.json();
  } catch (e) {
    console.error('[propostas.js] erro ao buscar tipos do usuário', e);
    localStorage.removeItem('token');
    window.location.href = 'index.html';
    return;
  }

  const isAluno = tiposUsuario.some(t => t.id_tipo === 1);

  // Botão Nova Proposta
  const acoesAlunoEl = document.getElementById('acoesAluno');
  if (isAluno) {
    acoesAlunoEl.style.display = 'block';
    document.getElementById('btnNovaProposta').addEventListener('click', () => {
      window.location.href = 'nova_proposta.html';
    });
  }

  // Carrega e exibe propostas
  try {
    const resp = await fetch(apiUrl('/api/propostas'), { headers });
    if (!resp.ok) throw new Error('Erro ao carregar propostas');
    const propostas = await resp.json();

    const tabelaEl = document.getElementById('tabelaPropostas');
    const tbody = tabelaEl.querySelector('tbody');
    const semPropostaEl = document.getElementById('semProposta');

    if (!propostas.length) {
      tabelaEl.style.display = 'none';
      semPropostaEl.style.display = 'block';
      if (isAluno) {
        semPropostaEl.textContent = 'Não há propostas cadastradas. Inclua uma proposta.';
      } else {
        semPropostaEl.textContent = 'Não há propostas cadastradas. Aguarde alguma proposta.';
      }
      return;
    }

    // Monta tabela quando existem propostas
    semPropostaEl.style.display = 'none';
    tabelaEl.style.display = 'table';
    tbody.innerHTML = '';

    propostas.forEach(p => {
      const show = (isAluno && p.id_estagiario === userId) ||
                   (!isAluno && ((p.id_professor === userId) || (p.id_orientador === userId)));
      if (!show) return;
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>${p.id_proposta}</td>
        <td>${p.escola_nome}</td>
        <td>${p.area_nome}</td>
        <td>${p.modalidade_nome}</td>
        <td>${p.status}</td>
        <td><button class="btn" onclick="acompanhar(${p.id_proposta})">Acompanhar</button></td>
      `;
      tbody.appendChild(tr);
    });
  } catch (e) {
    console.error('[propostas.js] erro ao carregar propostas', e);
    document.getElementById('tabelaPropostas').style.display = 'none';
    const semPropostaEl = document.getElementById('semProposta');
    semPropostaEl.textContent = 'Erro ao carregar propostas.';
    semPropostaEl.style.display = 'block';
  }
});

// Redireciona para acompanhar
function acompanhar(id) {
  window.location.href = `acompanhar.html?id=${id}`;
}
