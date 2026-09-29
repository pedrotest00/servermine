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

echo "==> Iniciando servico Playit..."
sudo systemctl start playit

for _ in {1..10}; do
  [[ -S /run/playit/playitd.sock ]] && break
  sleep 1
done

if [[ ! -S /run/playit/playitd.sock ]]; then
  echo "ERRO: Playit nao ficou pronto."
  sudo systemctl status playit --no-pager || true
  sudo tail -n 60 /var/log/playit/playit.log 2>/dev/null || true
  exit 1
fi

echo "==> Playit pronto."
playit status || true

echo "==> Iniciando Minecraft Fabric..."
exec ./start.sh
