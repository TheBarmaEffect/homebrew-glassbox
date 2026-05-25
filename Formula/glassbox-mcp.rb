class GlassboxMcp < Formula
  desc "Glass Box Framework MCP server — runtime constitutional verification for AI answers"
  homepage "https://github.com/TheBarmaEffect/glassbox"
  url "https://registry.npmjs.org/@glassbox-framework/mcp/-/mcp-1.0.2.tgz"
  sha256 "a4f27af84c2b67c4969b49a7f1030e1f3bc00c6c6dd3a5f62880efb28f31f432"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      Glassbox MCP needs an Anthropic API key for the verification engines.
      Set it in your shell profile:

        export ANTHROPIC_API_KEY="sk-ant-..."

      To use with Claude Desktop, add this to claude_desktop_config.json:

        "mcpServers": {
          "glass-box": {
            "command": "#{HOMEBREW_PREFIX}/bin/glassbox-mcp",
            "env": { "ANTHROPIC_API_KEY": "sk-ant-..." }
          }
        }

      One v1 tool (glassbox_generate_trust_card) makes zero LLM calls
      and works without an API key — useful for trying the Trust Card
      assembly + audit hash flow before you wire up Anthropic.

      Built by Karthik Barma · MS AI · Northeastern University.
      Powered by Aura.
    EOS
  end

  test do
    # Listing tools doesn't need an API key — exercises the registration path.
    output = pipe_output(
      "#{bin}/glassbox-mcp",
      [
        '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"brew-test","version":"1.0"}}}',
        '{"jsonrpc":"2.0","method":"notifications/initialized"}',
        '{"jsonrpc":"2.0","id":2,"method":"tools/list"}',
      ].join("\n") + "\n",
    )
    assert_match "glassbox_verify_answer", output
    assert_match "glassbox_generate_trust_card", output
  end
end
