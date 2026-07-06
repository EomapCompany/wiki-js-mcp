#!/bin/sh
set -e

# Mirrors the validation in start-server.sh, adapted for the container
# (no venv check: dependencies are already installed in the image).

if [ -z "$WIKIJS_API_URL" ]; then
    echo "Error: WIKIJS_API_URL not set" >&2
    exit 1
fi

if [ -z "$WIKIJS_TOKEN" ] && [ -z "$WIKIJS_API_KEY" ] && [ -z "$WIKIJS_USERNAME" ]; then
    echo "Error: Either WIKIJS_TOKEN, WIKIJS_API_KEY, or WIKIJS_USERNAME must be set" >&2
    exit 1
fi

exec "$@"
