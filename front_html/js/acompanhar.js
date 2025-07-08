// js/acompanhar.js
console.log('[acompanhar.js] script loaded');

/**
 * Abre o PDF do documento em nova aba
 */
function downloadDocumento(id) {
  window.open(`/api/documentos/${id}/pdf`, '_blank');
}

let acompanhamentoData;

document.addEventListener('DOMContentLoaded', async () => {
  const params = new URLSearchParams(window.location.search);
  const idEstagio = params.get('id');
  if (!idEstagio) {
    alert('ID do estágio não informado.');
    window.location.href = 'propostas.html';
    return;
  }

  const token = localStorage.getItem('token');
  if (!token) {
    window.location.href = 'index.html';
    return;
  }
  const headers = { 'Authorization': 'Bearer ' + token };

  let data;
  try {
    const resp = await fetch(`/api/propostas/${idEstagio}/acompanhamento`, { headers });
    if (!resp.ok) throw new Error('Falha ao carregar dados de acompanhamento.');
    data = await resp.json();
    acompanhamentoData = data;
  } catch (err) {
    console.error('[acompanhar.js] erro:', err);
    alert(err.message);
    return;
  }

  // Preenche detalhes do estágio
  const detalhesEl = document.getElementById('detalhesEstagio');
  detalhesEl.innerHTML = `
    <p><strong>ID:</strong> ${data.estagio.id_estagio}</p>
    <p><strong>Escola:</strong> ${data.estagio.escola_nome}</p>
    <p><strong>Área:</strong> ${data.estagio.area_nome}</p>
    <p><strong>Modalidade:</strong> ${data.estagio.modalidade_nome}</p>
    <p><strong>Status:</strong> ${data.estagio.status}</p>
  `;

  // Preenche histórico de etapas com botão de download
  const tabelaEl = document.getElementById('tabelaEtapas');
  const tbody = tabelaEl.querySelector('tbody');
  if (data.etapas && data.etapas.length) {
    tabelaEl.style.display = 'table';
    tbody.innerHTML = '';
    data.etapas.forEach(e => {
      const tr = document.createElement('tr');
      const linkDocumento = e.id_documento
        ? `<a href="#" onclick="downloadDocumento(${e.id_documento}); return false;">${e.id_documento}</a>`
        : '-';
      tr.innerHTML = `
        <td>${new Date(e.data).toLocaleString()}</td>
        <td>${e.usuario_nome || '-'}</td>
        <td>${e.etapa}</td>
        <td>${linkDocumento}</td>
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
      <p><strong>Proof:</strong> ${JSON.stringify(data.blockchain.proof)}</p>
    `;
  }

  // Handler de atualização (permanece inalterado)
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
        const resp2 = await fetch(`/api/propostas/${idEstagio}/acompanhamento`, {
          method: 'POST',
          headers,
          body: formData
        });
        const result = await resp2.json();
        if (!resp2.ok) throw new Error(result.error || 'Erro ao atualizar estágio.');
        window.location.reload();
      } catch (e) {
        console.error('[acompanhar.js] erro atualização:', e);
        alert(e.message);
      }
    });

  // Handler de exclusão (permanece inalterado)
  const btnExcluir = document.getElementById('btnExcluirUsuario');
  if (btnExcluir) {
    btnExcluir.addEventListener('click', async () => {
      if (!confirm('Deseja realmente excluir este usuário?')) return;
      try {
        const estagiarioId = acompanhamentoData.estagio.id_estagiario;
        const resp = await fetch(`/api/usuarios/${estagiarioId}`, {
          method: 'DELETE',
          headers
        });
        if (!resp.ok) {
          const err = await resp.json();
          throw new Error(err.error || 'Falha ao excluir usuário.');
        }
        alert('Usuário excluído com sucesso.');
        window.location.href = 'propostas.html';
      } catch (e) {
        console.error('[acompanhar.js] erro exclusão usuário:', e);
        alert(e.message);
      }
    });
  }
});
