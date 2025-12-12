#!/usr/bin/env bash
set -euo pipefail

# Deploys the Hugo site from content/ -> public/ and syncs to staging or production.
# Usage:
#   ./scripts/deploy-site.sh --env staging
#   ./scripts/deploy-site.sh --env production
#
# Requirements:
#   - hugo installed and available in PATH
#   - rsync/ssh credentials set up for the target environment

ENVIRONMENT="staging"
HUGO_ARGS="--minify"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBLIC_DIR="$PROJECT_ROOT/public"

usage() {
    cat <<EOF
Usage: $(basename "$0") --env staging|production [--hugo-args "<extra args>"]

Options:
  --env           Target environment (staging or production). Default: staging.
  --hugo-args     Extra arguments to pass to Hugo (defaults to --minify).
Example:
  $(basename "$0") --env production --hugo-args "--minify --gc"
EOF
}

# Parse args
while [[ $# -gt 0 ]]; do
    case "$1" in
        --env)
            ENVIRONMENT="$2"
            shift 2
            ;;
        --hugo-args)
            HUGO_ARGS="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            exit 1
            ;;
    esac
done

case "$ENVIRONMENT" in
    staging)
        DEPLOY_HOST="staging.example.com"
        DEPLOY_PATH="/var/www/gridbuilding-staging"
        ;;
    production)
        DEPLOY_HOST="prod.example.com"
        DEPLOY_PATH="/var/www/gridbuilding"
        ;;
    *)
        echo "Invalid environment: $ENVIRONMENT (expected staging or production)"
        exit 1
        ;;
esac

echo "==> Building Hugo site ($ENVIRONMENT)..."
pushd "$PROJECT_ROOT" >/dev/null
hugo $HUGO_ARGS
popd >/dev/null

echo "==> Deploying to $ENVIRONMENT ($DEPLOY_HOST:$DEPLOY_PATH)..."
rsync -avz --delete "$PUBLIC_DIR"/ "$DEPLOY_HOST:$DEPLOY_PATH"

echo "✅ Deployment to $ENVIRONMENT complete."
