# Homebrew tap for Glassbox

```bash
brew tap thebarmaeffect/glassbox
brew install glassbox-mcp
```

This tap installs the **Glass Box Framework MCP server** — runtime constitutional
verification for AI answers, with claim-level reasoning chains, formal ECS
scoring, the 7-angle Glassbox Court red team, and deterministic SHA-256 audit
log IDs.

After install:

```bash
glassbox-mcp     # speaks MCP over stdio; pipe JSON-RPC in
```

The formula installs the [`@glassbox-framework/mcp`](https://www.npmjs.com/package/@glassbox-framework/mcp)
npm package and depends on Node 18+.

## Use with Claude Desktop

Add to `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "glass-box": {
      "command": "/opt/homebrew/bin/glassbox-mcp",
      "env": { "ANTHROPIC_API_KEY": "sk-ant-..." }
    }
  }
}
```

## Source

Full project: <https://github.com/TheBarmaEffect/glassbox>

Built by **Karthik Barma** · MS AI · Northeastern University.
**Powered by Aura.**
