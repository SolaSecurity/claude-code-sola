# Sola Security

Ask security questions in natural language. One connection gives Claude full visibility across every data source connected to your Sola workspace.

## What it does

Sola exposes 7 read-only tools over its MCP server (`https://api.sola.security/mcp`):

| Tool | What it does |
|---|---|
| `list_apps` | Lists all workspace apps with IDs and names |
| `get_app_details` | Returns full app context — integrations, connectors, vendors, tables, queries, canvases, monitoring rules |
| `get_app_queries` | Retrieves saved SQL queries for an app |
| `get_vendor_tables` | Discovers available vendor tables, optionally filtered by vendor |
| `get_vendor_schemas` | Column-level schema details (names, types, descriptions) for vendor tables |
| `execute_sql_query` | Runs read-only SELECT statements against your connected data sources |
| `explore_data` | Natural language questions answered using Sola's graph intelligence and security expertise |

All access is read-only. Queries are scoped to your workspace — no cross-tenant data access.

---

## Getting started

**Prerequisite — Personal Token.** Open the Sola web app → **Settings → Privacy and Security → Personal Tokens** and generate a token. You'll use it as the OAuth Client ID below. Full docs: [docs.sola.security/getting-started/sola-ai/sola-mcp](https://docs.sola.security/getting-started/sola-ai/sola-mcp).

---

## Installation

### Claude Code

```bash
claude mcp add --transport http \
  --client-id YOUR_CLIENT_ID \
  --callback-port 9876 \
  sola "https://api.sola.security/mcp"
```

Start a session and run `/mcp` to complete OAuth. A ready-to-run script is in [`examples/claude-code.sh`](./examples/claude-code.sh): export `SOLA_CLIENT_ID` and execute it.

### Claude Desktop / Claude.ai

**Settings → Connectors → Add custom connector**, then:
- **Name:** `Sola`
- **Remote MCP server URL:** `https://api.sola.security/mcp`
- **Advanced settings → OAuth Client ID:** paste your token, then **Add**.

### Cursor

**Settings → Tools & MCPs → New MCP Server**, paste:

```json
{
  "mcpServers": {
    "sola": {
      "type": "http",
      "url": "https://api.sola.security/mcp",
      "auth": {
        "CLIENT_ID": "YOUR_CLIENT_ID"
      }
    }
  }
}
```

Return to **Tools & MCPs** and connect the Sola MCP.

### Other MCP clients

Copy [`examples/mcp.json`](./examples/mcp.json) into your client's MCP configuration and replace `YOUR_CLIENT_ID` with your Sola Personal Token.

---

## Example queries

```
What data sources do I have connected?
Who has admin access across my cloud accounts?
What are the most critical misconfigurations in my AWS environment?
Which users haven't logged in for more than 90 days?
Show me all resources out of compliance with our policies.
Run the saved query "weekly IAM audit" and summarize the results.
What tables are available in my AWS vendor?
```

---

## Configuration

Optional headers for fine-tuned control:

| Header | Default | Max | What it does |
|---|---|---|---|
| `x-create-resources` | false | — | Save generated queries and canvases back to Sola |
| `x-query-timeout` | 5 min | 10 min | Maximum query execution time |
| `x-query-rows-limit` | — | 100,000 | Cap on rows returned |
| `x-query-memory-limit` | — | 10 MiB | Cap on response size |

---

## Data access

Read-only access to your Sola workspace: connected data sources, apps, queries, and vendor tables. Access is role-based per app — Claude sees exactly what your Sola account can see, nothing more.

---

## Privacy

Data accessed through Sola MCP is governed by Sola's [Privacy Policy](https://sola.security/privacy-policy) and your workspace's data-sharing settings.

## Support

- Docs: [docs.sola.security](https://docs.sola.security)
- Email: support@sola.security
