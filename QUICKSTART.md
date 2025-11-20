# Quick Start Guide

Get up and running with Claude Profile Switcher in 5 minutes.

## Install

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/claude-profile-switcher.git

# Install to Claude Code
mkdir -p ~/.claude/plugins/marketplaces/custom
cp -r claude-profile-switcher ~/.claude/plugins/marketplaces/custom/profile-switcher
chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh

# Enable the plugin
claude plugin enable profile-switcher@custom
```

## Configure

In Claude Code, run:
```
/profile-setup
```

Answer the prompts:
- Corporate gateway URL (or leave empty)
- API key helper path (or leave empty)
- Corporate npm registry (or leave empty)
- Settings to sync (recommended: enabledPlugins, mcpServers)

## Use

### Switch to Personal
```
/switch-personal
```

### Switch to Corporate
```
/switch-corporate
```

### Check Status
```
/profile-status
```

## Example: Epic Games Setup

If you're at Epic Games (or similar setup):

```
/profile-setup
```

Then provide:
- Gateway URL: `https://live.ai.epicgames.com`
- npm Registry: `https://artifacts.ol.epicgames.net/artifactory/api/npm/npm-all/`
- API Helper: `/path/to/claude-gateway-helper/dist/jwt-token-helper.js`
- Sync: `enabledPlugins, mcpServers`

Done! Now you can switch with:
```
/switch-personal  # Use personal Claude account
/switch-corporate # Use Epic Games gateway
```

## Troubleshooting

### Plugin not showing?
```bash
# Check it's installed
ls ~/.claude/plugins/marketplaces/custom/profile-switcher/manifest.json

# Enable it
claude plugin enable profile-switcher@custom

# Restart Claude Code
```

### Scripts not working?
```bash
# Make sure they're executable
chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh

# Fix line endings (Windows)
sed -i 's/\r$//' ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh
```

### Settings not syncing?
```bash
# Check Python is installed
python3 --version

# If not, install it:
# Ubuntu: sudo apt install python3
# macOS: brew install python3
```

## What Gets Synced?

By default, these settings sync between profiles:
- All enabled plugins
- All MCP servers

These DON'T sync (profile-specific):
- Authentication tokens
- API key helper configuration
- Gateway URLs

## Aliases (Optional)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
alias sp='bash ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/switch-personal.sh'
alias sc='bash ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/switch-corporate.sh'
```

Now switch with just `sp` or `sc` in terminal!

## Need Help?

- Full docs: See [README.md](README.md)
- Installation issues: See [INSTALLATION.md](INSTALLATION.md)
- Report bugs: GitHub Issues

## Next Steps

1. Try switching between profiles
2. Install a plugin in one profile, switch, see it sync
3. Add MCP server, switch, see it sync
4. Customize your configuration as needed

That's it! You now have seamless profile switching with automatic settings sync.
