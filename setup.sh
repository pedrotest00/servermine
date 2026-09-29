#!/usr/bin/env bash
set -euo pipefail

MC_VERSION="${MC_VERSION:-1.20.1}"
PAPER_JAR="${PAPER_JAR:-server.jar}"
USER_AGENT="servermine/1.0 (https://github.com/pedrotest00/servermine)"

echo "==> Atualizando lista de pacotes..."
sudo apt update

echo "==> Instalando dependencias do tutorial (curl, gpg, jq e Java 17)..."
sudo apt install -y curl gpg jq openjdk-17-jre-headless

echo "==> Java instalado:"
java -version

echo "==> Buscando build estavel do Paper para Minecraft ${MC_VERSION}..."
BUILDS_RESPONSE="$(curl -fsSL   -H "User-Agent: ${USER_AGENT}"   "https://fill.papermc.io/v3/projects/paper/versions/${MC_VERSION}/builds")"

PAPER_URL="$(printf '%s' "${BUILDS_RESPONSE}" |   jq -r 'first(.[] | select(.channel == "STABLE") | .downloads."server:default".url) // empty')"

if [[ -z "${PAPER_URL}" ]]; then
  echo "ERRO: nao encontrei um build STABLE do Paper para ${MC_VERSION}."
  echo "Escolha outra versao, por exemplo: MC_VERSION=1.20.1 ./setup.sh"
  exit 1
fi

echo "==> Baixando Paper..."
curl -fL   -H "User-Agent: ${USER_AGENT}"   -o "${PAPER_JAR}"   "${PAPER_URL}"

chmod +x start.sh

echo
echo "Pronto. Paper salvo em ${PAPER_JAR}."
echo "Execute: ./start.sh"
echo "Na primeira execucao, leia a EULA e altere eula.txt somente se voce concordar."
