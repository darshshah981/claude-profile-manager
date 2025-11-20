# Installation Guide

## Quick Start

### For End Users

1. **Install the plugin**
   ```bash
   # When available on marketplace:
   claude plugin install profile-switcher

   # Or manually:
   git clone https://github.com/your-org/claude-profile-switcher
   cp -r claude-profile-switcher ~/.claude/plugins/marketplaces/custom/profile-switcher
   ```

2. **Enable the plugin**
   ```bash
   claude plugin enable profile-switcher
   ```

3. **Run setup**
   In Claude Code, run:
   ```
   /profile-setup
   ```

4. **Start using it**
   ```
   /switch-personal
   /switch-corporate
   ```

## Detailed Installation

### Prerequisites

- Claude Code v1.0.0 or higher
- Python 3.6+ (for settings sync)
- npm (if using npm registry switching)

### Method 1: From Claude Code Marketplace (Future)

Once published to the official marketplace:

```bash
claude plugin install profile-switcher
```

### Method 2: Manual Installation

1. **Download the plugin**

   ```bash
   # Clone the repository
   git clone https://github.com/your-org/claude-profile-switcher.git

   # Or download and extract the ZIP
   wget https://github.com/your-org/claude-profile-switcher/archive/main.zip
   unzip main.zip
   ```

2. **Install to Claude Code plugins directory**

   ```bash
   # Create custom marketplace directory if it doesn't exist
   mkdir -p ~/.claude/plugins/marketplaces/custom

   # Copy plugin to plugins directory
   cp -r claude-profile-switcher ~/.claude/plugins/marketplaces/custom/profile-switcher

   # Make scripts executable
   chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh
   ```

3. **Enable the plugin in Claude Code**

   Edit `~/.claude/settings.json` and add:
   ```json
   {
     "enabledPlugins": {
       "profile-switcher@custom": true
     }
   }
   ```

   Or use the command:
   ```bash
   claude plugin enable profile-switcher@custom
   ```

4. **Verify installation**

   In Claude Code, you should now see these commands available:
   - `/profile-setup`
   - `/profile-status`
   - `/switch-personal`
   - `/switch-corporate`

### Method 3: For Organizations (Custom Deployment)

Organizations can pre-configure the plugin for their teams:

1. **Fork and customize**

   ```bash
   git clone https://github.com/your-org/claude-profile-switcher.git
   cd claude-profile-switcher
   ```

2. **Create organization config template**

   Create `scripts/org-config.json`:
   ```json
   {
     "corporateGatewayUrl": "https://your-corp-gateway.com",
     "corporateNpmRegistry": "https://your-npm-registry.com/npm/",
     "apiKeyHelperPath": "/path/to/your/gateway-helper/jwt-token-helper.js",
     "syncSettings": ["enabledPlugins", "mcpServers"],
     "customNpmCommands": {
       "onSwitchToCorporate": [
         "npm config set registry https://your-registry.com",
         "npm config set //your-registry.com/:_authToken YOUR_TOKEN"
       ],
       "onSwitchToPersonal": [
         "npm config delete registry",
         "npm config delete //your-registry.com/:_authToken"
       ]
     }
   }
   ```

3. **Create installation script**

   Create `install-for-org.sh`:
   ```bash
   #!/bin/bash

   # Install plugin
   mkdir -p ~/.claude/plugins/marketplaces/custom
   cp -r . ~/.claude/plugins/marketplaces/custom/profile-switcher

   # Copy org config
   mkdir -p ~/.claude/profiles
   cp scripts/org-config.json ~/.claude/profiles/profile-switcher-config.json

   # Make scripts executable
   chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh

   echo "Profile switcher installed with organization defaults"
   echo "Run /profile-status in Claude Code to verify"
   ```

4. **Distribute to team**

   Share the repository or create a package:
   ```bash
   # Create distributable package
   tar -czf claude-profile-switcher-org.tar.gz claude-profile-switcher/

   # Team members can install with:
   # tar -xzf claude-profile-switcher-org.tar.gz
   # cd claude-profile-switcher
   # bash install-for-org.sh
   ```

## Post-Installation Setup

### First-Time Configuration

1. **Run the setup wizard**

   In Claude Code:
   ```
   /profile-setup
   ```

   This will ask you for:
   - Corporate gateway URL (optional)
   - API key helper path (optional)
   - Corporate npm registry (optional)
   - Which settings to sync

2. **Initialize profiles**

   The setup will create:
   - `~/.claude/profiles/personal-settings.json`
   - `~/.claude/profiles/corporate-settings.json`
   - `~/.claude/profiles/profile-switcher-config.json`
   - Token backup directories

3. **Test the switch**

   Try switching between profiles:
   ```
   /switch-personal
   /profile-status
   /switch-corporate
   /profile-status
   ```

### Shell Aliases (Optional)

For convenience, add aliases to `~/.bashrc` or `~/.zshrc`:

```bash
# Add to ~/.bashrc or ~/.zshrc
alias sp='bash ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/switch-personal.sh'
alias sc='bash ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/switch-corporate.sh'
```

Then reload your shell:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

Now you can switch with just `sp` or `sc` from the terminal.

## Troubleshooting Installation

### Plugin not showing in Claude Code

1. Check plugin is in correct directory:
   ```bash
   ls ~/.claude/plugins/marketplaces/custom/profile-switcher/manifest.json
   ```

2. Verify it's enabled in settings:
   ```bash
   cat ~/.claude/settings.json | grep profile-switcher
   ```

3. Restart Claude Code

### Scripts not executable

```bash
chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh
```

### Python not found error

Install Python 3:
```bash
# Ubuntu/Debian
sudo apt install python3

# macOS
brew install python3

# Verify
python3 --version
```

### Permissions issues

Ensure directories are writable:
```bash
chmod -R u+w ~/.claude/
```

## Updating the Plugin

### From Marketplace (Future)

```bash
claude plugin update profile-switcher
```

### Manual Update

```bash
# Backup your config first
cp ~/.claude/profiles/profile-switcher-config.json ~/profile-switcher-config-backup.json

# Update the plugin
cd ~/claude-profile-switcher
git pull origin main

# Copy to plugins directory
cp -r . ~/.claude/plugins/marketplaces/custom/profile-switcher/

# Restore config
cp ~/profile-switcher-config-backup.json ~/.claude/profiles/profile-switcher-config.json
```

## Uninstallation

To remove the plugin:

```bash
# Disable in Claude Code first
claude plugin disable profile-switcher

# Remove plugin files
rm -rf ~/.claude/plugins/marketplaces/custom/profile-switcher

# Optionally remove profile data (CAUTION: backs up settings)
rm -rf ~/.claude/profiles/profile-switcher-config.json
# DO NOT remove ~/.claude/profiles/*-settings.json unless you're sure
```

Your profile backups (`personal-settings.json`, `corporate-settings.json`) will be preserved.

## Next Steps

After installation:

1. Read the [README.md](README.md) for usage instructions
2. Check out [CONTRIBUTING.md](CONTRIBUTING.md) if you want to customize
3. Report issues at: https://github.com/your-org/claude-profile-switcher/issues
