// js/api.js

// URL base do backend (mude aqui quando for publicar/deploy)
const API_BASE = "http://localhost:3000";

// Função utilitária para montar URLs completas da API
function apiUrl(path) {
  if (!path.startsWith('/')) path = '/' + path;
  return API_BASE + path;
}
