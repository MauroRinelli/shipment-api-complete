#!/bin/bash

# Script testing API Shipment
# Testa tutti gli endpoint in sequenza

BASE_URL="http://localhost:3000/api/shipments"
TRACKING="TRK$(date +%s)" # Genera tracking number unico

echo "======================================"
echo "🧪 TEST API GESTIONE SPEDIZIONI"
echo "======================================"
echo ""

# 1. Health Check
echo "1️⃣  TEST: Health Check"
echo "GET $BASE_URL/ping"
curl -s $BASE_URL/ping | jq
echo ""

# 2. Crea Spedizione
echo "2️⃣  TEST: Crea Spedizione"
echo "POST $BASE_URL"
curl -s -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d "{
    \"trackingNumber\": \"$TRACKING\",
    \"destination\": {
      \"city\": \"Pontedera\",
      \"country\": \"Italia\"
    },
    \"carrier\": \"BRT\"
  }" | jq
echo ""

# 3. Lista Spedizioni
echo "3️⃣  TEST: Lista Spedizioni"
echo "GET $BASE_URL"
curl -s $BASE_URL | jq
echo ""

# 4. Dettaglio Spedizione
echo "4️⃣  TEST: Dettaglio Spedizione"
echo "GET $BASE_URL/$TRACKING"
curl -s $BASE_URL/$TRACKING | jq
echo ""

# 5. Aggiorna Stato
echo "5️⃣  TEST: Aggiorna Stato"
echo "PUT $BASE_URL/$TRACKING"
curl -s -X PUT $BASE_URL/$TRACKING \
  -H "Content-Type: application/json" \
  -d '{"status": "IN_TRANSIT"}' | jq
echo ""

# 6. Test Errore: Status Invalido
echo "6️⃣  TEST: Errore Status Invalido (Atteso 400)"
echo "PUT $BASE_URL/$TRACKING"
curl -s -X PUT $BASE_URL/$TRACKING \
  -H "Content-Type: application/json" \
  -d '{"status": "WRONG_STATUS"}' | jq
echo ""

# 7. Test Errore: Spedizione Non Trovata
echo "7️⃣  TEST: Errore Spedizione Non Trovata (Atteso 404)"
echo "GET $BASE_URL/NOTEXIST999"
curl -s $BASE_URL/NOTEXIST999 | jq
echo ""

# 8. Elimina Spedizione
echo "8️⃣  TEST: Elimina Spedizione"
echo "DELETE $BASE_URL/$TRACKING"
curl -s -X DELETE $BASE_URL/$TRACKING | jq
echo ""

echo "======================================"
echo "✅ TEST COMPLETATI"
echo "======================================"
