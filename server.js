require('dotenv').config();
const express = require('express');
const connectDB = require('./config/db');
const shipmentRoutes = require('./routes/shipments');

// Inizializza Express
const app = express();

// Middleware
app.use(express.json()); // Parser body JSON
app.use(express.urlencoded({ extended: true })); // Parser form data

// CORS per frontend
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// Serve static files (frontend)
app.use(express.static('public'));

// Middleware logging richieste (sviluppo)
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Connetti Database
connectDB();

// Routes
app.use('/api/shipments', shipmentRoutes);

// Route base
app.get('/', (req, res) => {
  res.json({
    message: 'API Gestione Spedizioni Solespress',
    version: '1.0.0',
    endpoints: {
      ping: 'GET /api/shipments/ping',
      createShipment: 'POST /api/shipments',
      getAllShipments: 'GET /api/shipments',
      getShipment: 'GET /api/shipments/:trackingNumber',
      updateStatus: 'PUT /api/shipments/:trackingNumber',
      deleteShipment: 'DELETE /api/shipments/:trackingNumber'
    }
  });
});

// Error handler 404
app.use((req, res) => {
  res.status(404).json({ 
    error: 'Endpoint non trovato' 
  });
});

// Error handler globale
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Errore server interno' 
  });
});

// Avvia server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`
╔══════════════════════════════════════════╗
║  🚀 Server avviato con successo          ║
║  📡 Porta: ${PORT}                        ║
║  🌍 Ambiente: ${process.env.NODE_ENV || 'development'}              ║
║  📦 API: http://localhost:${PORT}         ║
╚══════════════════════════════════════════╝
  `);
});

module.exports = app;
