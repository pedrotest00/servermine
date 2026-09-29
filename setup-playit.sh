#!/usr/bin/env bash
set -euo pipefail

echo "==> Instalando dependencias do Playit..."
sudo apt update
sudo apt install -y curl gpg ca-certificates

echo "==> Adicionando repositorio oficial do playit.gg..."
curl -SsL https://playit-cloud.github.io/ppa/key.gpg   | gpg --dearmor   | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null

echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./"   | sudo tee /etc/apt/sources.list.d/playit-cloud.list >/dev/null

sudo apt update
sudo apt install -y playit

if ! command -v playit >/dev/null 2>&1; then
  echo "ERRO: o comando playit nao foi encontrado apos a instalacao."
  exit 1
fi

echo "==> Iniciando/reiniciando o servico do Playit..."
sudo systemctl restart playit

echo "==> Aguardando o socket IPC do Playit..."
for _ in {1..15}; do
  if [[ -S /run/playit/playitd.sock ]]; then
    echo "Playit instalado e o daemon esta pronto."
    echo "Socket: /run/playit/playitd.sock"
    echo
    echo "Agora execute: playit setup"
    exit 0
  fi
  sleep 1
done

echo "ERRO: o servico nao criou /run/playit/playitd.sock."
echo
echo "Status do servico:"
sudo systemctl status playit --no-pager || true
echo
echo "Ultimas linhas do log:"
sudo tail -n 60 /var/log/playit/playit.log 2>/dev/null || sudo journalctl -u playit -n 60 --no-pager || true
exit 1
