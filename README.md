# ha-eufy-sdk-addon

The Home Assistant **add-on** wrapper around
[`ha-eufy-sdk-bridge`](https://github.com/mega-yfue/ha-eufy-sdk-bridge). A thin repository the
Supervisor can install: it pulls the bridge's Docker image, surfaces `EUFY_EMAIL` /
`EUFY_PASSWORD` / `EUFY_COUNTRY` as add-on options, and exposes the daemon through **ingress** (which
also provides the auth the raw WS lacks).

Same image runs both ways: HA OS / Supervised install this add-on; HA Container / Core run the bridge
image directly. The [`ha-eufy-sdk`](https://github.com/mega-yfue/ha-eufy-sdk) integration accepts a
URL and uses Supervisor discovery to auto-fill it on the add-on path.

## Install

Add this repository in **Settings → Add-ons → Add-on Store → ⋮ → Repositories**, then install
**eufy-sdk bridge**.

## Where it fits

| Repo | Role |
| --- | --- |
| [`eufy-sdk`](https://github.com/mega-yfue/eufy-sdk) | the HA-agnostic library |
| [`ha-eufy-sdk-bridge`](https://github.com/mega-yfue/ha-eufy-sdk-bridge) | WS + HTTP + go2rtc daemon (Docker) |
| **`ha-eufy-sdk-addon`** | **this** — Supervisor add-on wrapper |
| [`ha-eufy-sdk`](https://github.com/mega-yfue/ha-eufy-sdk) | the HACS integration (front door) |

> Status: scaffolding. `repository.json` + the add-on `config.yaml` land next.
