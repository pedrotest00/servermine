#!/usr/bin/env bash
set -euo pipefail

PLAYIT_RUNTIME="${PLAYIT_RUNTIME:-/tmp/servermine-playit-$UID}"
PLAYIT_SOCKET="${PLAYIT_SOCKET:-$PLAYIT_RUNTIME/playitd.sock}"

./start-playit.sh

echo
echo "==> Configurando Playit..."
echo "Abra no navegador a URL que aparecer abaixo e autorize o agente."
echo

exec playit --socket-path "$PLAYIT_SOCKET" setup
