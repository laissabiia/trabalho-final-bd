// js/propostas.js

console.log('[propostas.js] script loaded');

document.addEventListener('DOMContentLoaded', async () => {
  const token = localStorage.getItem('token');
  if (!token) {
    window.location.href = 'index.html';
    return;
  }
  const headers = { 'Authorization': 'Bearer ' + token };

  // Decodifica token e busca perfil completo
  let perfil;
  try {
    const payload = JSON.parse(atob(token.split('.')[1]));
    const userId = payload.id;
    const perfilRes = await fetch(apiUrl(`/api/usuarios/${userId}/perfil`), { headers });
    if (!perfilRes.ok) throw new Error('Não autenticado');
    perfil = await perfilRes.json();
  } catch (e) {
    console.error('[propostas.js] erro ao buscar perfil', e);
    localStorage.removeItem('token');
    window.location.href = 'index.html';
    return;
  }

  const isAluno = Boolean(perfil.estagiario);
  const estagiarioId = perfil.estagiario?.id_estagiario;

  // Botão "Nova Proposta"
  const acoesAlunoEl = document.getElementById('acoesAluno');
  if (isAluno) {
    acoesAlunoEl.style.display = 'block';
    document.getElementById('btnNovaProposta')
      .addEventListener('click', () => window.location.href = 'nova_proposta.html');
  }

  // Carrega propostas
  try {
    const resp = await fetch(apiUrl('/api/propostas'), { headers });
    if (!resp.ok) throw new Error('Erro ao carregar propostas');
    const propostas = await resp.json();

    const tabelaEl = document.getElementById('tabelaPropostas');
    const tbody = tabelaEl.querySelector('tbody');
    const semEl = document.getElementById('semProposta');

    if (!propostas.length) {
      tabelaEl.style.display = 'none';
      semEl.style.display = 'block';
      semEl.textContent = isAluno
        ? 'Não há propostas cadastradas. Inclua uma proposta.'
        : 'Não há propostas cadastradas. Aguarde alguma proposta.';
      return;
    }

    // Popula tabela apenas para o estagiário
    semEl.style.display = 'none';
    tabelaEl.style.display = 'table';
    tbody.innerHTML = '';

    propostas.forEach(p => {
      if (isAluno && p.id_estagiario !== estagiarioId) return;
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>${p.id_estagio}</td>
        <td>${p.escola_nome}</td>
        <td>${p.area_nome}</td>
        <td>${p.modalidade_nome}</td>
        <td>${p.status}</td>
        <td><button class="btn" onclick="acompanhar(${p.id_estagio})">Acompanhar</button></td>
      `;
      tbody.appendChild(tr);
    });
  } catch (e) {
    console.error('[propostas.js] erro ao carregar propostas', e);
    document.getElementById('tabelaPropostas').style.display = 'none';
    const semEl = document.getElementById('semProposta');
    semEl.textContent = 'Erro ao carregar propostas.';
    semEl.style.display = 'block';
  }
});

// Redireciona para acompanhar
function acompanhar(id) {
  window.location.href = `acompanhar.html?id=${id}`;
}
