# Claude Code Profile Switcher

A plugin for Claude Code that allows seamless switching between personal and corporate profiles while automatically syncing settings, plugins, and MCP servers.

## Features

- Switch between personal and corporate Claude Code profiles with a single command
- Automatic backup of current settings before switching
- Intelligent sync of enabled plugins and MCP servers across profiles
- Token management (preserves authentication across switches)
- npm registry switching support
- Configurable for any corporate setup

## Installation

### From Claude Code

```bash
claude plugin install profile-switcher
```

### Manual Installation

1. Clone or download this repository
2. Place it in `~/.claude/plugins/marketplaces/custom/`
3. Enable the plugin in Claude Code settings

## Initial Setup

Run the setup command to configure for your organization:

```
/profile-setup
```

This will guide you through:
1. Corporate gateway URL configuration
2. API key helper path (if using corporate SSO)
3. npm registry settings
4. Which settings to sync between profiles

## Usage

### Switch to Personal Profile

```
/switch-personal
```

This will:
1. Backup current settings to the active profile
2. Sync common settings (plugins, MCP servers) between profiles
3. Switch to personal authentication
4. Restore personal tokens
5. Configure npm for public registry

### Switch to Corporate Profile

```
/switch-corporate
```

This will:
1. Backup current settings to the active profile
2. Sync common settings (plugins, MCP servers) between profiles
3. Switch to corporate gateway authentication
4. Restore corporate tokens
5. Configure npm for corporate registry

### Check Current Profile

```
/profile-status
```

Shows:
- Currently active profile
- Enabled plugins
- MCP servers configured
- npm registry
- Last sync time

## Configuration

### Plugin Settings

The plugin can be configured via Claude Code settings or by editing `~/.claude/profiles/profile-switcher-config.json`:

```json
{
  "corporateGatewayUrl": "https://your-corp-gateway.com",
  "corporateNpmRegistry": "https://your-npm-registry.com/npm/",
  "apiKeyHelperPath": "/path/to/gateway-helper/jwt-token-helper.js",
  "syncSettings": ["enabledPlugins", "mcpServers"],
  "customNpmCommands": {
    "onSwitchToCorporate": [
      "npm config set registry https://your-registry.com"
    ],
    "onSwitchToPersonal": [
      "npm config delete registry"
    ]
  }
}
```

### Synced Settings

By default, these settings are synced between profiles:
- **enabledPlugins**: All enabled plugins (union of both profiles)
- **mcpServers**: All configured MCP servers (union of both profiles)

Optionally, you can also sync:
- **alwaysThinkingEnabled**: Thinking mode preference

Settings that are NEVER synced (profile-specific):
- **apiKeyHelper**: Corporate gateway configuration
- **tokens**: Authentication tokens (backed up separately)

## How It Works

### Profile Structure

```
~/.claude/
├── settings.json                    # Active settings (gets replaced on switch)
├── gateway-helper-config.json       # Corporate gateway config (corporate only)
├── tokens/                          # Active tokens
└── profiles/
    ├── personal-settings.json       # Personal profile backup
    ├── corporate-settings.json      # Corporate profile backup
    ├── corporate-gateway-config.json
    ├── tokens-personal/             # Personal tokens backup
    └── tokens-corporate/            # Corporate tokens backup
```

### Switching Process

1. **Backup Phase**
   - Detects current profile (checks for `apiKeyHelper` in settings)
   - Backs up `settings.json` to appropriate profile file
   - Backs up tokens to appropriate tokens folder

2. **Sync Phase**
   - Reads both profile files
   - Merges specified settings (plugins, MCP servers)
   - Writes merged settings to both profile files

3. **Switch Phase**
   - Copies target profile settings to `settings.json`
   - Restores target profile tokens
   - Configures gateway (if corporate)

4. **Post-Switch**
   - Configures npm registry
   - Displays summary

## Use Cases

### For Individual Developers
- Switch between personal Anthropic account and company SSO
- Keep plugins consistent across both profiles
- Maintain separate billing

### For Organizations
- Standardize profile switching across teams
- Share corporate gateway configuration
- Ensure compliance with corporate policies

## Compatibility

- **Claude Code**: v1.0.0+
- **Python**: 3.6+ (for settings sync)
- **npm**: Any version (for registry switching)
- **OS**: Linux, macOS, Windows (WSL)

## Advanced Configuration

### Custom Corporate Setup

For organizations with unique requirements:

1. Fork this plugin
2. Modify `commands/switch-corporate.md` to include your specific setup
3. Add custom scripts in `scripts/` directory
4. Distribute to your team via internal marketplace

### Example: Epic Games Setup

```json
{
  "corporateGatewayUrl": "https://live.ai.epicgames.com",
  "corporateNpmRegistry": "https://artifacts.ol.epicgames.net/artifactory/api/npm/npm-all/",
  "apiKeyHelperPath": "/home/user/.nvm/versions/node/v22.21.0/lib/node_modules/claude-gateway-helper/dist/jwt-token-helper.js"
}
```

## Troubleshooting

### Settings not syncing
- Ensure Python 3 is installed: `python3 --version`
- Check profile files exist: `ls ~/.claude/profiles/`

### Tokens not preserved
- Check tokens backup directories: `ls ~/.claude/profiles/tokens-*`
- Re-authenticate if needed: `claude logout && claude login`

### npm registry not switching
- Verify npm is installed: `npm --version`
- Check current registry: `npm config get registry`
- Manually set if needed: `npm config set registry <url>`

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Test with both personal and corporate profiles
4. Submit a pull request

## License

MIT License - feel free to use and modify for your organization.

## Credits

Created by Darsh Shah for the Claude Code community.