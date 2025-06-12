// js/login.js
document.getElementById("loginForm").onsubmit = async function (e) {
  e.preventDefault();
  document.getElementById("errorMsg").textContent = "";
  const email = document.getElementById("email").value.trim();
  const senha = document.getElementById("senha").value;
  try {
    const resp = await fetch(apiUrl("/api/login"), {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, senha }),
    });

    const data = await resp.json();
    if (!resp.ok) {
      document.getElementById("errorMsg").textContent =
        data.error || "Falha no login";
    } else {
      setToken(data.token);
      window.location.href = "propostas.html";
    }
  } catch (err) {
    document.getElementById("errorMsg").textContent =
      "Erro ao conectar ao servidor";
  }
};
