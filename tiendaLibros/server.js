const cds = require('@sap/cds');

cds.on('bootstrap', () => { console.log("Paso por bootstrap") });
cds.on('served', () => { console.log("Paso por served") });

module.exports = cds.server;