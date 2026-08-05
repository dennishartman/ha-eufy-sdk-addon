# Home Assistant Add-on: eufy-sdk bridge

Runs the [`ha-eufy-sdk-bridge`](https://github.com/mega-yfue/ha-eufy-sdk-bridge) daemon inside Home
Assistant, so the [`eufy-sdk`](https://github.com/mega-yfue/ha-eufy-sdk) HACS integration has a bridge
to talk to without you running Docker yourself.

## How it works

The add-on builds `FROM` the bridge image and adds one thing: it reads your add-on options
(`email` / `password` / `country`) and passes them to the bridge as the env it expects. The daemon +
its bundled go2rtc then start automatically. Ingress fronts the control/HTTP port (`:3000`); go2rtc's
RTSP/WebRTC ports are hosted for LAN streaming.

## Configuration

| Option | Description |
| --- | --- |
| `email` | eufy account email |
| `password` | eufy account password |
| `country` | Two-letter country code (e.g. `GB`) — routes the eufy region |

The login token persists in the add-on's `/data`, so a restart does not re-authenticate (eufy allows
one active session per account).

> Status: scaffolding — depends on the `ha-eufy-sdk-bridge` image being published.
