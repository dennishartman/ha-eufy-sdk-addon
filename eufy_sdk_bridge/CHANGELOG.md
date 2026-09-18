# Changelog

## 0.3.0

- Surface the bridge's **Anker Solix** settings as add-on options: `solix_email` / `solix_password` /
  `solix_country` (a SEPARATE Anker account — adds Solarbank / smart-meter entities), plus
  `solix_scene_poll_ms`, `solix_retry_base_ms`, `solix_retry_max_ms`. All optional; empty email/password
  keeps Solix off, so eufy-only setups are unaffected. (Solix runs today on the **dev** add-on, which
  tracks the bridge `:dev` image; the stable image gains it when its pinned bridge release catches up.)
- New **dev / edge** add-on — `eufy-sdk bridge (dev)`, `stage: experimental` (hidden unless HA Advanced
  Mode is on), branded with a red "DEV" ribbon. It builds from the bridge's rolling `:dev` image so
  testers can try changes before a stable release; a GitHub **pre-release** publishes it.
- Register Supervisor **discovery**, so the `eufy-sdk` integration auto-fills the bridge host + ports.
- Bump `home-assistant/builder` to 2026.09.0.

## 0.2.1

- Publish the bridge control port `3000/tcp` so the `eufy-sdk` integration can reach the bridge directly
  (ingress is an HA-frontend-authenticated proxy the raw-WS client can't traverse).
- Real add-on icon + logo (replaced the EXAMPLE placeholders).

## 0.2.0

- First public add-on: thin wrapper over `ha-eufy-sdk-bridge` published as release-driven prebuilt
  multi-arch images (amd64 + aarch64), options → env, ingress, and the go2rtc media ports.

## 0.1.36

- Track bridge `0.1.36`; pin `build_from` to the versioned ghcr tag (was floating `:latest`).
- Expose the bridge's tuning knobs as add-on options: `poll_ms`, `stream_idle_ms`, `rtsp_idle_off_ms`,
  and `debug` — each mirrors the bridge default, so existing setups are unaffected.

## 0.1.0

- Initial scaffold: thin add-on wrapper over `ha-eufy-sdk-bridge` (options → env, ingress, go2rtc ports).
