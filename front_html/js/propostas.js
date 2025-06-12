// js/propostas.js

// Protege a página (redireciona se não estiver logado)
if (!isAuthenticated()) {
  window.location.href = "index.html";
}

// Mostra o nome do usuário (opcional, pode ler do token)
let usuarioNome = "";
try {
  const token = getToken();
  if (token) {
    // Decodifica só o payload (não valida assinatura)
    const payload = JSON.parse(atob(token.split('.')[1]));
    usuarioNome = payload.nome || payload.email || "";
  }
} catch {}
document.getElementById("bemvindo").textContent = usuarioNome ? "Bem-vindo, " + usuarioNome : "";

// Logout
document.getElementById("logoutBtn").onclick = function() {
  removeToken();
  window.location.href = "index.html";
};

// Carregar propostas do usuário
async function carregarPropostas() {
  const lista = document.getElementById("listaPropostas");
  lista.innerHTML = "Carregando...";
  try {
    const resp = await fetch(apiUrl("/api/propostas"), {
      headers: { Authorization: "Bearer " + getToken() }
    });
    if (!resp.ok) throw new Error("Erro ao buscar propostas");
    const propostas = await resp.json();
    if (!propostas.length) {
      lista.innerHTML = "<div>Nenhuma proposta cadastrada.</div>";
      return;
    }
    lista.innerHTML = "";
    propostas.forEach(p => {
      const div = document.createElement("div");
      div.style = "margin-bottom:10px; padding: 12px; border-radius:8px; background:#f5f7fa; border:1px solid #e0e0e0;";
      div.textContent = `Proposta #${p.id_proposta} | Status: ${p.status}`;
      // Você pode adicionar mais campos/detalhes aqui
      lista.appendChild(div);
    });
  } catch (err) {
    lista.innerHTML = "Erro ao carregar propostas.";
  }
}
carregarPropostas();

document.getElementById("novaPropostaBtn").onclick = function() {
  window.location.href = "nova_proposta.html";
};
