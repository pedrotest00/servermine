#!/usr/bin/env bash
set -euo pipefail

MC_VERSION="${MC_VERSION:-26.2}"
LOADER_VERSION="${LOADER_VERSION:-0.19.5}"
INSTALLER_VERSION="${INSTALLER_VERSION:-1.1.2}"
SERVER_JAR="${SERVER_JAR:-server.jar}"

echo "==> Atualizando pacotes..."
sudo apt update

echo "==> Instalando Java 25 e dependencias..."
sudo apt install -y curl ca-certificates gpg jq openjdk-25-jdk

echo "==> Java em uso:"
java -version

JAVA_MAJOR="$(java -version 2>&1 | awk -F[\".] '/version/ {print $2; exit}')"
if [[ -z "${JAVA_MAJOR}" || "${JAVA_MAJOR}" -lt 25 ]]; then
  echo "ERRO: Minecraft 26.2 requer Java 25 ou superior."
  exit 1
fi

FABRIC_URL="https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${LOADER_VERSION}/${INSTALLER_VERSION}/server/jar"

echo "==> Baixando Fabric Server..."
echo "Minecraft: ${MC_VERSION}"
echo "Loader:    ${LOADER_VERSION}"
echo "Launcher:  ${INSTALLER_VERSION}"

curl -fL --retry 3 -o "${SERVER_JAR}" "${FABRIC_URL}"

if [[ ! -s "${SERVER_JAR}" ]]; then
  echo "ERRO: o download do Fabric nao gerou um server.jar valido."
  exit 1
fi

mkdir -p mods
chmod +x start.sh setup-playit.sh start-playit.sh start-all.sh

echo
echo "Fabric ${MC_VERSION} preparado em ${SERVER_JAR}."
echo "Agora execute: ./start.sh"
echo "Na primeira inicializacao, leia e aceite a EULA manualmente caso concorde."
