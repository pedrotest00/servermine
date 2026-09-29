#!/usr/bin/env bash
set -euo pipefail

RAM="${RAM:-1G}"
PAPER_JAR="${PAPER_JAR:-server.jar}"

if [[ ! -f "${PAPER_JAR}" ]]; then
  echo "ERRO: ${PAPER_JAR} nao existe."
  echo "Execute primeiro: ./setup.sh"
  exit 1
fi

echo "Iniciando Paper com limite de memoria de ${RAM}..."
exec java -Xmx"${RAM}" -jar "${PAPER_JAR}" nogui
