# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# This add-on is a THIN WRAPPER over ha-eufy-sdk-bridge: it builds FROM the bridge image and adds only
# the glue that turns Home Assistant add-on options into the env the bridge reads. `BUILD_FROM` is set
# per-arch in build.yaml to the published bridge image.
ARG BUILD_FROM=ghcr.io/mega-yfue/ha-eufy-sdk-bridge:0.2.0
FROM ${BUILD_FROM}

# The bridge base is node:alpine (no s6/bashio). `jq` reads /data/options.json and `curl` registers
# Supervisor discovery with the effective add-on network mapping.
RUN apk add --no-cache curl jq

# The upstream bridge currently derives the stream budget from the device's reported battery
# capability. Allow selected, physically wired devices to override that classification at runtime.
# No serial is baked into the image: FORCE_WIRED_SERIALS comes from private Home Assistant options.
RUN grep -q 'const feed = await cam.openReadable();' /app/src/http-routes.mjs \
    && sed -i 's|const feed = await cam.openReadable();|const feed = await cam.openReadable((process.env.FORCE_WIRED_SERIALS ?? "").split(",").map((value) => value.trim()).filter(Boolean).includes(sn) ? { powered: "wired" } : undefined);|' /app/src/http-routes.mjs

# SDK 0.1.0 assumes every 64,000-byte video payload has a continuation. Some models send a complete
# access unit at exactly that size; make the alternative behavior an explicit runtime opt-in.
RUN grep -q 'var STATION_CHUNK_BYTES = 64e3;' /app/node_modules/@mega-yfue/eufy-sdk/dist/index.js \
    && sed -i 's|var STATION_CHUNK_BYTES = 64e3;|var STATION_CHUNK_BYTES = process.env.TREAT_64000_AS_COMPLETE === "1" ? -1 : 64e3;|' /app/node_modules/@mega-yfue/eufy-sdk/dist/index.js

COPY run.sh /run.sh
RUN chmod +x /run.sh

LABEL \
    org.opencontainers.image.title="Home Assistant Add-on: eufy-sdk bridge (wired)" \
    org.opencontainers.image.description="Runs the ha-eufy-sdk bridge with an optional wired-stream override." \
    org.opencontainers.image.source="https://github.com/dennishartman/ha-eufy-sdk-addon" \
    org.opencontainers.image.licenses="MIT"

CMD [ "/run.sh" ]
