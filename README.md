# API REST Gestione Spedizioni - Solespress

API completa per la gestione delle spedizioni con Node.js, Express e MongoDB.

## 📋 Requisiti

- Node.js >= 14.x
- MongoDB >= 4.x (locale o Atlas)
- npm o yarn

## 🚀 Setup

### 1. Installa dipendenze
```bash
npm install
```

### 2. Configura variabili ambiente
Crea file `.env` nella root (usa `.env.example` come template):
```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/shipment_db
```

### 3. Avvia MongoDB
**Locale:**
```bash
mongod
```

**MongoDB Atlas:**
Sostituisci `MONGODB_URI` con la tua connection string.

### 4. Avvia server
```bash
npm start
```

**Sviluppo (con auto-reload):**
```bash
npm run dev
```

## 📡 Endpoint API

Base URL: `http://localhost:3000/api/shipments`

### 1. Health Check
```bash
GET /ping
```
**Response:**
```json
{
  "message": "Server online",
  "status": "ok"
}
```

### 2. Crea Spedizione
```bash
POST /
Content-Type: application/json

{
  "trackingNumber": "TRK123456",
  "destination": {
    "city": "Pontedera",
    "country": "Italia"
  },
  "carrier": "BRT",
  "status": "PENDING"
}
```
**Response (201):**
```json
{
  "success": true,
  "data": {
    "trackingNumber": "TRK123456",
    "destination": {
      "city": "Pontedera",
      "country": "Italia"
    },
    "status": "PENDING",
    "date": "2024-01-15T10:30:00.000Z",
    "carrier": "BRT",
    "_id": "65a5b3c...",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z"
  }
}
```

### 3. Lista Tutte Spedizioni
```bash
GET /
```
**Response (200):**
```json
{
  "success": true,
  "count": 2,
  "data": [...]
}
```

### 4. Dettaglio Spedizione
```bash
GET /:trackingNumber
```
**Esempio:**
```bash
GET /TRK123456
```

### 5. Aggiorna Stato
```bash
PUT /:trackingNumber
Content-Type: application/json

{
  "status": "IN_TRANSIT"
}
```
**Stati validi:** `PENDING`, `IN_TRANSIT`, `DELIVERED`, `FAILED`

### 6. Elimina Spedizione
```bash
DELETE /:trackingNumber
```

## 🧪 Testing con cURL

### Health Check
```bash
curl http://localhost:3000/api/shipments/ping
```

### Crea Spedizione
```bash
curl -X POST http://localhost:3000/api/shipments \
  -H "Content-Type: application/json" \
  -d '{
    "trackingNumber": "TRK001",
    "destination": {
      "city": "Roma",
      "country": "Italia"
    },
    "carrier": "UPS"
  }'
```

### Lista Spedizioni
```bash
curl http://localhost:3000/api/shipments
```

### Dettaglio Spedizione
```bash
curl http://localhost:3000/api/shipments/TRK001
```

### Aggiorna Stato
```bash
curl -X PUT http://localhost:3000/api/shipments/TRK001 \
  -H "Content-Type: application/json" \
  -d '{"status": "DELIVERED"}'
```

### Elimina Spedizione
```bash
curl -X DELETE http://localhost:3000/api/shipments/TRK001
```

## 🧪 Testing con Postman

### Importa Collection
1. Apri Postman
2. File → Import
3. Crea nuova collection "Shipment API"
4. Aggiungi requests per ogni endpoint

### Variabili Ambiente Postman
```
base_url: http://localhost:3000/api/shipments
```

## ⚠️ Gestione Errori

### 400 - Bad Request
```json
{
  "error": "Il trackingNumber è obbligatorio"
}
```

### 404 - Not Found
```json
{
  "error": "Spedizione non trovata"
}
```

### 500 - Server Error
```json
{
  "error": "Errore server durante creazione spedizione"
}
```

## 📁 Struttura Progetto

```
shipment-api/
├── config/
│   └── db.js              # Configurazione MongoDB
├── models/
│   └── Shipment.js        # Schema Mongoose
├── routes/
│   └── shipments.js       # Routes API
├── .env                   # Variabili ambiente (NON committare)
├── .env.example           # Template variabili ambiente
├── package.json
├── server.js              # Entry point applicazione
└── README.md
```

## 🔧 Dipendenze

- **express**: Framework web
- **mongoose**: ODM MongoDB
- **dotenv**: Gestione variabili ambiente

## 📝 Note Sviluppo

- TrackingNumber normalizzato in UPPERCASE automaticamente
- Validazione enum su campo `status`
- Timestamp automatici (createdAt, updatedAt)
- Indice MongoDB su `trackingNumber` per performance
- Error handling robusto su tutti gli endpoint

## 🐛 Troubleshooting

**MongoDB non si connette:**
- Verifica che MongoDB sia avviato: `mongod`
- Controlla connection string in `.env`

**Porta già in uso:**
- Cambia `PORT` in `.env`
- Oppure termina processo: `lsof -ti:3000 | xargs kill`

**Errore dipendenze:**
```bash
rm -rf node_modules package-lock.json
npm install
```
