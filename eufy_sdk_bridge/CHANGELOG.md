# Changelog

## 0.1.36

- Track bridge `0.1.36`; pin `build_from` to the versioned ghcr tag (was floating `:latest`).
- Expose the bridge's tuning knobs as add-on options: `poll_ms`, `stream_idle_ms`, `rtsp_idle_off_ms`,
  and `debug` — each mirrors the bridge default, so existing setups are unaffected.

## 0.1.0

- Initial scaffold: thin add-on wrapper over `ha-eufy-sdk-bridge` (options → env, ingress, go2rtc ports).
