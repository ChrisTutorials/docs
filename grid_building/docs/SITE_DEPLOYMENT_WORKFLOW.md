# GridBuilding Site Deployment Workflow

This workflow builds the Hugo site (from `content/` → `public/`) and deploys it to either staging or production using the unified script.

## Prerequisites

- Hugo installed and available on PATH.
- SSH credentials for the staging/production hosts (configured for `rsync`).
- Ensure `main` contains the desired content changes before deploying.

## Quick Start

```bash
cd /home/chris/docs/grid_building
./scripts/deploy-site.sh --env staging
```

Switch `--env production` when ready for the live site. Use `--hugo-args` to pass extra flags (e.g., `--gc`).

## Detailed Steps

1. **Update Content**
   - Make edits under `content/` (v5.0, v5.1, v6.0) and commit on `main`.

2. **Run the Deployment Script**
   ```bash
   ./scripts/deploy-site.sh --env staging
   ```
   - Builds Hugo (`hugo --minify` by default) producing `public/`.
   - Syncs `public/` to the configured host/path for the target environment via `rsync --delete`.

3. **Verify**
   - Hit the staging site URL to confirm the latest changes.
   - For production, repeat with `--env production` once staging checks pass.

## Environment Targets

The script currently uses placeholders:

| Environment | Host                 | Path                        |
|-------------|----------------------|-----------------------------|
| staging     | `staging.example.com`| `/var/www/gridbuilding-staging` |
| production  | `prod.example.com`   | `/var/www/gridbuilding`         |

Update `scripts/deploy-site.sh` with real hostnames/paths for your infrastructure.

## Notes

- Generated `public/` is ignored on `main`; the script creates it locally per deploy.
- Optional `build-artifacts` branch can store historical snapshots if needed.
- Future CI integration should invoke the same script (or its logic) to keep parity between manual and automated deploys.
