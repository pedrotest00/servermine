#!/usr/bin/env bash
set -euo pipefail

if ! command -v playit >/dev/null 2>&1; then
  echo "ERRO: Playit nao esta instalado."
  echo "Execute primeiro: ./setup-playit.sh"
  exit 1
fi

echo "Iniciando agente playit.gg..."
exec playit
