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

echo
if command -v playit >/dev/null 2>&1; then
  echo "Playit instalado com sucesso."
  echo "Binario: $(command -v playit)"
  if dpkg-query -W -f='${Version}\n' playit >/dev/null 2>&1; then
    echo "Pacote: $(dpkg-query -W -f='${Version}\n' playit)"
  fi
else
  echo "ERRO: o comando playit nao foi encontrado apos a instalacao."
  exit 1
fi

echo
echo "Proximo passo: execute 'playit setup'."
echo "Abra a URL exibida no terminal para vincular ESTE agente a sua conta."
echo "Depois crie um tunel Minecraft Java para 127.0.0.1:25565."
