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

| Option | Default | Description |
| --- | --- | --- |
| `email` | — | eufy account email |
| `password` | — | eufy account password |
| `country` | `GB` | Two-letter country code — routes the eufy region |
| `poll_ms` | `600000` | How often the bridge re-reads device state from the cloud (ms); `0` disables polling |
| `stream_idle_ms` | `300000` | Auto-off a camera's live feed after this long with no detection (ms); `0` disables. Saves battery |
| `rtsp_idle_off_ms` | `300000` | Turn a **battery** camera's native `rtspStream` OFF after this long idle (ms); `0` disables. Wired cameras untouched |
| `debug` | `false` | Verbose bridge logging (WS commands, control timing, P2P connect/close) |

The four tuning options mirror the bridge's own defaults, so leaving them unchanged behaves exactly as
before. The login token persists in the add-on's `/data`, so a restart does not re-authenticate (eufy
allows one active session per account; a session bumped elsewhere re-authenticates, escalating to 2FA).
