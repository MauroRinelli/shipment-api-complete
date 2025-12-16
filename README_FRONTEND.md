# Sistema Gestione Spedizioni Solespress - Completo

Sistema completo Backend API + Frontend Web per gestione spedizioni.

## 📦 Contenuto

```
shipment-api/
├── server.js                 # Server Express (Backend)
├── package.json              # Dipendenze
├── .env                      # Configurazione DB
├── config/db.js              # Connessione MongoDB
├── models/Shipment.js        # Schema spedizioni
├── routes/shipments.js       # API REST endpoints
└── public/
    ├── index.html            # Frontend Web App
    ├── solespress_logo.png   # Logo aziendale
    └── qr_site.png           # QR code sito
```

## 🚀 Avvio Applicazione

### 1. Server già avviato
```bash
# Il server è già in esecuzione su porta 3000
# ✅ MongoDB connesso
```

### 2. Accedi Frontend
Apri browser e vai su:
```
http://localhost:3000
```

## 🎯 Funzionalità Frontend

### Dashboard
- Statistiche totali spedizioni
- Contatori per stato (Attesa, Transito, Consegnate)
- Visualizzazione spedizioni recenti

### Crea Spedizione
- Form inserimento dati
- Campi: Tracking, Corriere, Stato, Destinazione
- Validazione input
- Feedback immediato

### Lista Spedizioni
- Tabella completa tutte le spedizioni
- Ricerca per tracking/città/corriere
- Aggiornamento stato inline
- Eliminazione spedizione

## 📡 API Endpoints (Backend)

```
GET    /api/shipments/ping          # Health check
POST   /api/shipments                # Crea spedizione
GET    /api/shipments                # Lista tutte
GET    /api/shipments/:tracking      # Dettaglio singola
PUT    /api/shipments/:tracking      # Aggiorna stato
DELETE /api/shipments/:tracking      # Elimina
```

## 🎨 Design

- Colori brand Solespress (verde #4CAF50, rosso #d32f2f)
- Logo aziendale integrato
- Responsive mobile-first
- Interfaccia user-friendly operatori

## 🔧 Tecnologie

**Backend:**
- Node.js + Express
- MongoDB Atlas (cloud)
- Mongoose ODM

**Frontend:**
- HTML5 + CSS3
- JavaScript Vanilla (no framework)
- Fetch API per chiamate REST

## 📱 Accesso Rapido

1. **Apri browser**: http://localhost:3000
2. **Dashboard**: panoramica immediata
3. **Crea spedizione**: tab "Nuova Spedizione"
4. **Gestisci**: tab "Lista Spedizioni"

## 🧪 Test Workflow Completo

1. Click "Nuova Spedizione"
2. Compila form:
   - Tracking: TRK001
   - Corriere: BRT
   - Città: Pontedera
   - Paese: Italia
3. Click "Crea Spedizione"
4. Vai su "Lista Spedizioni"
5. Click "Aggiorna" per cambiare stato
6. Dashboard aggiorna statistiche automaticamente

## 🔒 Sicurezza Produzione

Per deploy produzione, modifica:
- Rimuovi `Access-Control-Allow-Origin: *` 
- Aggiungi autenticazione JWT
- Usa HTTPS
- Environment variables sicure

## 💡 Note Operative

- Server deve essere **sempre attivo** per usare frontend
- Modifiche salvate in MongoDB Atlas (persistenti)
- Dati accessibili da qualsiasi dispositivo con browser
- Logo/QR personalizzabili in `/public`

## 📞 Support

Sistema pronto per operatori Solespress.
Frontend accessibile da qualsiasi PC/tablet in rete locale.
