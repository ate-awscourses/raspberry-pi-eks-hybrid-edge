#!/usr/bin/env bash
set -euo pipefail

# Find the project directory, regardless of where the script is run.
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

# AWS destination.
S3_BUCKET="raspberry-pi-edge-telemetry-62674486ed9021f5a706c9e331"

# Collect fresh Raspberry Pi metrics.
python3 scripts/edge_telemetry.py

# Create a unique, time-based S3 object path.
HOSTNAME="$(hostname)"
TIMESTAMP="$(date -u +%Y/%m/%d/%H%M%S)"
S3_KEY="telemetry/${HOSTNAME}/${TIMESTAMP}.json"

# Upload the JSON file using the AWS CLI's existing credentials.
aws s3 cp data/telemetry.json \
  "s3://${S3_BUCKET}/${S3_KEY}" \
  --only-show-errors

echo "Telemetry uploaded to s3://${S3_BUCKET}/${S3_KEY}"
