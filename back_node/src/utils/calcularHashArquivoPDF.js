const fs = require("fs");
const crypto = require("crypto");

async function calcularHashArquivoPDF(path) {
  const buffer = fs.readFileSync(path);
  const hash = crypto.createHash("sha256").update(buffer).digest("hex");
  return hash;
}

module.exports = calcularHashArquivoPDF;
