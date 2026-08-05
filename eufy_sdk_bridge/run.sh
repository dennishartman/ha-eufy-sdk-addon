#!/bin/sh
# Add-on entrypoint: translate Home Assistant add-on options → the env the bridge reads, then hand off.
#
# HA writes the user's options to /data/options.json (not env), so this is the one glue step the thin
# wrapper adds on top of the bridge image. /data is the add-on's persistent volume, so the login token
# survives restarts (eufy allows ONE session per account — re-auth escalates to 2FA).
set -e

OPTS=/data/options.json

export EUFY_EMAIL="$(jq -r '.email // ""' "$OPTS")"
export EUFY_PASSWORD="$(jq -r '.password // ""' "$OPTS")"
export EUFY_COUNTRY="$(jq -r '.country // "GB"' "$OPTS")"
export EUFY_SESSION="/data/.eufy-session.json"
# Reachable through ingress + the hosted go2rtc ports (not just localhost).
export BRIDGE_HOST="0.0.0.0"

# Contract with ha-eufy-sdk-bridge: the bridge image provides this launcher, which starts the daemon
# AND go2rtc. Defined here so the wrapper stays a pure options→env shim.
exec /usr/local/bin/eufy-sdk-bridge
