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
  echo "ERRO: o comando playit nao foi encontrado."
  exit 1
fi

if ! command -v playitd >/dev/null 2>&1 && [[ ! -x /opt/playit/playitd ]]; then
  echo "ERRO: o daemon playitd nao foi encontrado."
  exit 1
fi

chmod +x start-playit.sh configure-playit.sh start-all.sh

echo
echo "Playit instalado com sucesso."
echo "Este Codespace nao usa systemd, entao o projeto executa playitd diretamente."
echo
echo "Proximo passo:"
echo "  ./configure-playit.sh"
