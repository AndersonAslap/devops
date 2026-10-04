const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

function getBrazilDateTime() {
  return new Intl.DateTimeFormat('pt-BR', {
    timeZone: 'America/Sao_Paulo',
    dateStyle: 'full',
    timeStyle: 'long'
  }).format(new Date());
}

function getUptime() {
  const seconds = process.uptime();

  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  const s = Math.floor(seconds % 60);

  return `${h}h ${m}m ${s}s`;
}


const { version } = require('./package.json');

app.get('/', (req, res) => {
  res.status(200).json({
    status: "success",
    message: "Aplicação rodando com sucesso 🚀",
    dateTime: getBrazilDateTime(),
    version: version,
    uptime: getUptime(),
    environment: process.env.NODE_ENV || "development",
    hostname: require('os').hostname()
  });
});

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});