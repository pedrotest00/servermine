#!/usr/bin/env bash
set -euo pipefail

PLAYIT_BASE="${PLAYIT_BASE:-$HOME/.local/share/servermine-playit}"
PLAYIT_RUNTIME="${PLAYIT_RUNTIME:-/tmp/servermine-playit-$UID}"
PLAYIT_SECRET="${PLAYIT_SECRET:-$PLAYIT_BASE/playit.toml}"
PLAYIT_LOG="${PLAYIT_LOG:-$PLAYIT_BASE/playit.log}"
PLAYIT_SOCKET="${PLAYIT_SOCKET:-$PLAYIT_RUNTIME/playitd.sock}"
PLAYIT_PID="${PLAYIT_PID:-$PLAYIT_RUNTIME/playitd.pid}"

PLAYITD_BIN="$(command -v playitd 2>/dev/null || true)"
if [[ -z "$PLAYITD_BIN" && -x /opt/playit/playitd ]]; then
  PLAYITD_BIN=/opt/playit/playitd
fi

if [[ -z "$PLAYITD_BIN" ]]; then
  echo "ERRO: playitd nao esta instalado."
  echo "Execute primeiro: ./setup-playit.sh"
  exit 1
fi

mkdir -p "$PLAYIT_BASE" "$PLAYIT_RUNTIME"
chmod 700 "$PLAYIT_BASE" "$PLAYIT_RUNTIME" 2>/dev/null || true

if [[ -f "$PLAYIT_PID" ]]; then
  OLD_PID="$(cat "$PLAYIT_PID" 2>/dev/null || true)"
  if [[ -n "$OLD_PID" ]] && kill -0 "$OLD_PID" 2>/dev/null && [[ -S "$PLAYIT_SOCKET" ]]; then
    echo "Playit ja esta ativo (PID $OLD_PID)."
    playit --socket-path "$PLAYIT_SOCKET" status || true
    exit 0
  fi
fi

rm -f "$PLAYIT_SOCKET" "$PLAYIT_PID"

echo "==> Iniciando playitd sem systemd..."
nohup "$PLAYITD_BIN"   --secret-path "$PLAYIT_SECRET"   --socket-path "$PLAYIT_SOCKET"   -l "$PLAYIT_LOG"   >/dev/null 2>&1 &

DAEMON_PID=$!
echo "$DAEMON_PID" > "$PLAYIT_PID"

for _ in {1..20}; do
  if [[ -S "$PLAYIT_SOCKET" ]]; then
    echo "Playit daemon pronto."
    echo "Socket: $PLAYIT_SOCKET"
    echo "PID:    $DAEMON_PID"
    if [[ -f "$PLAYIT_SECRET" ]]; then
      playit --socket-path "$PLAYIT_SOCKET" status || true
    else
      echo "Este agente ainda precisa ser vinculado."
      echo "Execute: ./configure-playit.sh"
    fi
    exit 0
  fi

  if ! kill -0 "$DAEMON_PID" 2>/dev/null; then
    echo "ERRO: playitd encerrou antes de criar o socket."
    echo
    echo "Log:"
    cat "$PLAYIT_LOG" 2>/dev/null || true
    exit 1
  fi

  sleep 0.5
done

echo "ERRO: playitd nao criou o socket a tempo."
echo
echo "Log:"
cat "$PLAYIT_LOG" 2>/dev/null || true
exit 1
