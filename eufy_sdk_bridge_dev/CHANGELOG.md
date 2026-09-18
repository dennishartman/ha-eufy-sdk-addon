# Changelog

## 0.3.0-dev.1

- Initial **dev / edge** channel of the eufy-sdk bridge add-on. Same wrapper as the stable
  `eufy_sdk_bridge`, but it builds FROM the bridge's rolling `:dev` image so testers get changes
  before a stable release. Marked `stage: experimental` (hidden unless HA Advanced Mode is on).
- Distinct slug/image (`eufy_sdk_bridge_dev` / `ghcr.io/mega-yfue/addon-eufy-sdk-bridge-dev`); shares
  the stable add-on's ports and options. Run only ONE bridge per eufy account (a second displaces the
  first's session).
