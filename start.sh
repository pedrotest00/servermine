#!/usr/bin/env bash
set -euo pipefail

RAM="${RAM:-6G}"
MIN_RAM="${MIN_RAM:-2G}"
SERVER_JAR="${SERVER_JAR:-server.jar}"

if [[ ! -f "${SERVER_JAR}" ]]; then
  echo "ERRO: ${SERVER_JAR} nao existe."
  echo "Execute primeiro: ./setup.sh"
  exit 1
fi

echo "Iniciando Minecraft 26.2 Fabric..."
echo "RAM minima: ${MIN_RAM} | RAM maxima: ${RAM}"

exec java -Xms"${MIN_RAM}" -Xmx"${RAM}" -jar "${SERVER_JAR}" nogui
