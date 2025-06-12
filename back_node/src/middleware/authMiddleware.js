const jwt = require("jsonwebtoken");
const JWT_SECRET = process.env.JWT_SECRET || "segredo_supersecreto";

function authMiddleware(req, res, next) {
  console.log("[AUTH MIDDLEWARE] Rota:", req.originalUrl);
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: "Token não enviado" });

  const token = authHeader.split(" ")[1];
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = payload;
    next();
  } catch (error) {
    console.log("Token inválido: ", req.originalUrl);
    return res.status(401).json({ error: "Token inválido" });
  }
}

module.exports = authMiddleware;
