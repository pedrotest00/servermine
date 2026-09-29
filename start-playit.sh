#!/usr/bin/env bash
set -euo pipefail

if ! command -v playit >/dev/null 2>&1; then
  echo "ERRO: Playit nao esta instalado."
  echo "Execute primeiro: ./setup-playit.sh"
  exit 1
fi

echo "==> Iniciando servico playit..."
sudo systemctl start playit

for _ in {1..10}; do
  if [[ -S /run/playit/playitd.sock ]]; then
    echo "Playit ativo."
    playit status || true
    exit 0
  fi
  sleep 1
done

echo "ERRO: o socket /run/playit/playitd.sock nao apareceu."
sudo systemctl status playit --no-pager || true
sudo tail -n 60 /var/log/playit/playit.log 2>/dev/null || true
exit 1
