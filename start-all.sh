#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f "${SERVER_JAR:-server.jar}" ]]; then
  echo "ERRO: servidor Fabric ainda nao foi instalado."
  echo "Execute primeiro: ./setup.sh"
  exit 1
fi

echo "==> Preparando Playit..."
./start-playit.sh

PLAYIT_BASE="${PLAYIT_BASE:-$HOME/.local/share/servermine-playit}"
PLAYIT_SECRET="${PLAYIT_SECRET:-$PLAYIT_BASE/playit.toml}"

if [[ ! -f "$PLAYIT_SECRET" ]]; then
  echo
  echo "ERRO: o Playit ainda nao foi vinculado a sua conta."
  echo "Execute uma vez: ./configure-playit.sh"
  exit 1
fi

echo
echo "==> Iniciando Minecraft Fabric..."
exec ./start.sh
