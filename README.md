# claude-switch

A simple shell script to switch between personal and corporate Claude Code profiles.

If you use Claude Code both at work (through a corporate AI gateway) and for personal projects (with your own subscription), this tool makes switching between them seamless.

## What It Does

- **Switches Claude authentication** - Swaps `settings.json` and gateway configurations between profiles
- **Syncs plugins and MCP servers** - Keeps your extensions consistent across both profiles
- **Switches npm registry** (optional) - Toggles between corporate Artifactory and public npmjs.org
- **Manages tokens** - Backs up and restores authentication tokens for each profile

## Quick Start

### 1. Install

```bash
# Download the script
curl -o ~/.local/bin/claude-switch https://raw.githubusercontent.com/darshshah981/claude-profile-manager/main/claude-switch

# Make it executable
chmod +x ~/.local/bin/claude-switch

# Ensure ~/.local/bin is in your PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Or clone the repo:

```bash
git clone https://github.com/darshshah981/claude-profile-manager.git
cd claude-profile-manager
cp claude-switch ~/.local/bin/
chmod +x ~/.local/bin/claude-switch
```

### 2. Initialize Configuration

```bash
claude-switch init
```

This creates a config file at `~/.claude/profiles/config.sh`. Edit it to match your setup.

### 3. Set Up Your Profiles

First, configure Claude Code for your **corporate** profile (with your gateway), then save it:

```bash
# After configuring corporate Claude Code
claude-switch corporate
```

Then configure Claude Code for your **personal** profile and save it:

```bash
# After configuring personal Claude Code
claude-switch personal
```

The script will automatically back up your settings when you switch.

### 4. Switch Profiles

```bash
# Switch to corporate
claude-switch corporate

# Switch to personal
claude-switch personal

# Check current status
claude-switch status
# or just
claude-switch
```

## Configuration

Edit `~/.claude/profiles/config.sh` to customize:

```bash
# Profile names (use any names you want)
PERSONAL_PROFILE_NAME="personal"
CORPORATE_PROFILE_NAME="work"  # or "corporate", "enterprise", etc.

# Corporate gateway settings
CORPORATE_GATEWAY_URL="https://ai-gateway.yourcompany.com"
CORPORATE_GATEWAY_NAME="portkey"  # or "aws-bedrock", "azure-openai"

# NPM registry (optional - set SWITCH_NPM_REGISTRY=true to enable)
CORPORATE_NPM_REGISTRY="https://artifactory.yourcompany.com/api/npm/npm-all/"
SWITCH_NPM_REGISTRY=true

# Feature flags
SYNC_PLUGINS=true         # Sync plugins across profiles
SYNC_MCP_SERVERS=true     # Sync MCP servers across profiles
BACKUP_TOKENS=true        # Backup/restore auth tokens
```

## How It Works

### Profile Storage

```
~/.claude/profiles/
    config.sh                    # Your configuration
    personal-settings.json       # Personal Claude settings
    corporate-settings.json      # Corporate Claude settings
    corporate-gateway-config.json
    tokens-personal/             # Personal auth tokens
    tokens-corporate/            # Corporate auth tokens
```

### Plugin and MCP Server Sync

When you install a plugin or configure an MCP server in one profile, `claude-switch` merges it into both profiles on the next switch. This means:

1. Install a plugin while using personal profile
2. Run `claude-switch corporate`
3. The plugin is now available in corporate profile too

The sync uses Python to merge JSON settings (Python 3 required).

### Detection

The script detects which profile is active by looking for `apiKeyHelper` in `settings.json`. If found, you're in corporate mode; otherwise, personal mode.

## Example Output

```
$ claude-switch corporate

Switching to CORPORATE Profile
========================================

[1/4] Backing up current configuration...
OK Backed up personal tokens

[2/4] Syncing plugins and MCP servers...
  Synced enabledPlugins across profiles
  Synced mcpServers across profiles

[3/4] Switching Claude authentication...
OK Loaded corporate settings
OK Configured gateway

[4/4] Switching NPM registry...
OK NPM registry: https://artifactory.yourcompany.com/api/npm/npm-all/

========================================
CORPORATE Profile Active
========================================

Gateway: https://ai-gateway.yourcompany.com
Next: Run 'claude' to start
```

## Requirements

- Bash 4.0+
- Python 3 (for plugin/MCP sync)
- npm (if using npm registry switching)

## Troubleshooting

### "Python3 not found, skipping settings sync"

Install Python 3:

```bash
# Ubuntu/Debian
sudo apt install python3

# macOS
brew install python3
```

### Tokens not persisting

Make sure `BACKUP_TOKENS=true` in your config.

### NPM registry not switching

1. Set `SWITCH_NPM_REGISTRY=true` in config
2. Set `CORPORATE_NPM_REGISTRY` to your registry URL
3. Optionally set `CORPORATE_NPM_PATTERN` for detection

### Profile not detected correctly

Adjust `CORPORATE_DETECTION_PATTERN` in config to match something unique in your corporate `settings.json`.

## License

MIT License - see [LICENSE](LICENSE) file.

## Related

- [Claude Code](https://claude.ai/claude-code) - The AI coding assistant this tool supports
- [Blog post](https://darsh.dev/posts/claude-code-at-work-solving-enterprise-authentication) - Detailed explanation of the enterprise authentication problem and solution
