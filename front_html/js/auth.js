// js/auth.js
function setToken(token) {
  localStorage.setItem('token', token);
}
function getToken() {
  return localStorage.getItem('token');
}
function removeToken() {
  localStorage.removeItem('token');
}
function isAuthenticated() {
  return !!getToken();
}
