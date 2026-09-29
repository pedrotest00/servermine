#!/usr/bin/env bash
set -euo pipefail

if ! command -v playit >/dev/null 2>&1; then
  echo "ERRO: Playit nao esta instalado."
  echo "Execute primeiro: ./setup-playit.sh"
  exit 1
fi

if [[ ! -f "${SERVER_JAR:-server.jar}" ]]; then
  echo "ERRO: servidor Fabric ainda nao foi instalado."
  echo "Execute primeiro: ./setup.sh"
  exit 1
fi

echo "==> Iniciando Playit em segundo plano..."
: > playit.log
playit > playit.log 2>&1 &
PLAYIT_PID=$!

cleanup() {
  if kill -0 "${PLAYIT_PID}" >/dev/null 2>&1; then
    kill "${PLAYIT_PID}" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT INT TERM

sleep 2

if ! kill -0 "${PLAYIT_PID}" >/dev/null 2>&1; then
  echo "ERRO: o Playit encerrou durante a inicializacao."
  cat playit.log
  exit 1
fi

echo "==> Playit iniciado. Log: playit.log"
echo "==> Iniciando Minecraft Fabric..."
./start.sh
