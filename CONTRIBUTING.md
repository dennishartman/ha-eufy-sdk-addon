# Contributing to ha-eufy-sdk-addon

Thanks for helping out! This guide covers **how we branch and merge** so your PR lands smoothly.

## Branch model — target `dev`, not `main`

We use two long-lived branches:

- **`dev`** — the integration branch. **All contributions go here.**
- **`main`** — release-only. Pushing to `main` builds and publishes the add-on image.

```
your branch  ──►  PR into `dev`  ──►  maintainer review + green CI  ──►  merged to dev
                                                                            │
                              (when a release is ready) maintainers open    ▼
                              a  dev ─► main  PR, merge it ──►  add-on image published
```

So the flow for a contribution is:

1. Fork (or, if you're a maintainer, branch the repo).
2. **Create your branch from `dev`.**
3. Make your change, keep it focused, update docs if behaviour changes.
4. **Open your pull request against `dev`.** PRs opened against `main` will be asked to retarget.
5. A maintainer reviews and merges.

> **Please don't open PRs into `main`.** `main` moves only when the maintainers cut a release by
> merging `dev → main`. Both `main` and `dev` are protected — everything lands via PR.

## Who can merge

- **Maintainers** (repo owners) can merge PRs and cut releases.
- **Everyone else**: your PR needs an approving review from a maintainer before it can merge. CI must
  be green.

## What CI checks

Every PR into `main`/`dev` runs:

- **Lint** (`.github/workflows/lint.yaml`) — the Home Assistant add-on linter over `eufy_sdk_bridge/`.
- **Builder** (`.github/workflows/builder.yaml`) — builds each changed app (no publish on PRs) so a
  broken `config.yaml` / `build.yaml` / `Dockerfile` is caught before merge.

Publishing happens only when a **GitHub Release** is published — the Builder then builds and pushes
the per-arch images (tagged with the `config.yaml` version) to `ghcr.io/mega-yfue`.

## Cutting a release (maintainers)

1. Bump `version:` in [`eufy_sdk_bridge/config.yaml`](./eufy_sdk_bridge/config.yaml) (and the pinned
   bridge tag in [`build.yaml`](./eufy_sdk_bridge/build.yaml) if the bridge moved).
2. Merge `dev → main`.
3. Publish a **GitHub Release** with the tag set to the new version. The Builder builds and pushes the
   per-arch add-on images; Supervisor pulls them by the version in `config.yaml`.

## Reporting bugs

Open an [issue](../../issues/new/choose) with a clear summary, steps to reproduce, what you expected
vs. what happened, and the add-on log (enable **debug** in the add-on Configuration tab).

## License

By contributing, you agree that your contributions are licensed under the project's
[MIT License](./LICENSE).
