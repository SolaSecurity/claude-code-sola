#!/usr/bin/env bash
# Install the Sola MCP server in Claude Code.
#
# Prerequisite: generate a Personal Token in the Sola web app
#   Settings → Privacy and Security → Personal Tokens
# and export it as SOLA_CLIENT_ID before running this script.

set -euo pipefail

: "${SOLA_CLIENT_ID:?Set SOLA_CLIENT_ID to your Sola Personal Token}"

claude mcp add --transport http \
  --client-id "$SOLA_CLIENT_ID" \
  --callback-port 9876 \
  sola "https://api.sola.security/mcp"

echo "Added. Start a Claude Code session and run /mcp to complete OAuth."
