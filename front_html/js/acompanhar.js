// js/acompanhar.js
console.log('[acompanhar.js] script loaded');

document.addEventListener('DOMContentLoaded', async () => {
  // Obtém o ID do estágio pela query string
  const params = new URLSearchParams(window.location.search);
  const idEstagio = params.get('id');
  if (!idEstagio) {
    alert('ID do estágio não informado.');
    window.location.href = 'propostas.html';
    return;
  }

  // Autenticação
  const token = localStorage.getItem('token');
  if (!token) {
    window.location.href = 'index.html';
    return;
  }
  const headers = { 'Authorization': 'Bearer ' + token };

  try {
    // Busca dados de acompanhamento (estágio, histórico de etapas e blockchain)
    const resp = await fetch(apiUrl(`/api/propostas/${idEstagio}/acompanhamento`), { headers });
    if (!resp.ok) throw new Error('Falha ao carregar dados de acompanhamento.');
    const data = await resp.json();

    // Preenche detalhes do estágio
    const detalhesEl = document.getElementById('detalhesEstagio');
    detalhesEl.innerHTML = `
      <p><strong>ID:</strong> ${data.estagio.id_estagio}</p>
      <p><strong>Escola:</strong> ${data.estagio.escola_nome}</p>
      <p><strong>Área:</strong> ${data.estagio.area_nome}</p>
      <p><strong>Modalidade:</strong> ${data.estagio.modalidade_nome}</p>
      <p><strong>Status:</strong> ${data.estagio.status}</p>
    `;

    // Preenche histórico de etapas
    const tabelaEl = document.getElementById('tabelaEtapas');
    const tbody = tabelaEl.querySelector('tbody');
    if (data.etapas && data.etapas.length) {
      tabelaEl.style.display = 'table';
      tbody.innerHTML = '';
      data.etapas.forEach(e => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${new Date(e.data).toLocaleString()}</td>
          <td>${e.usuario_nome}</td>
          <td>${e.etapa}</td>
          <td>${e.id_documento
            ? `<a href="\${apiUrl('/api/documentos/'+e.id_documento+'/pdf')}" target="_blank">${e.id_documento}</a>`
            : '-'}</td>
          <td>${e.hash_blockchain}</td>
          <td>${e.assinatura || '-'}</td>
          <td>${e.proof || '-'}</td>
        `;
        tbody.appendChild(tr);
      });
    } else {
      tabelaEl.style.display = 'none';
    }

    // Preenche dados gerais do blockchain
    const bcEl = document.getElementById('dadosBlockchain');
    if (data.blockchain) {
      bcEl.innerHTML = `
        <p><strong>Último Hash:</strong> ${data.blockchain.lastHash}</p>
        <p><strong>Proof:</strong> ${data.blockchain.proof}</p>
      `;
    }
  } catch (err) {
    console.error('[acompanhar.js] erro:', err);
    alert(err.message);
    return;
  }

  // Evento do botão de atualização
  document.getElementById('btnAtualizarEstagio')
    .addEventListener('click', async () => {
      const mensagem = document.getElementById('msgAcompanhamento').value.trim();
      const fileEl = document.getElementById('fileAcompanhamento');
      const formData = new FormData();
      formData.append('mensagem', mensagem);
      if (fileEl.files.length) {
        formData.append('arquivo_pdf', fileEl.files[0]);
      }

      try {
        const resp2 = await fetch(apiUrl(`/api/propostas/${idEstagio}/acompanhamento`), {
          method: 'POST',
          headers,
          body: formData
        });
        const result = await resp2.json();
        if (!resp2.ok) throw new Error(result.error || 'Erro ao atualizar estágio.');
        // Recarrega a página para exibir a nova etapa
        window.location.reload();
      } catch (e) {
        console.error('[acompanhar.js] erro atualização:', e);
        alert(e.message);
      }
    });
});
