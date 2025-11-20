# Claude Profile Switcher - Project Summary

## What We Built

A complete, production-ready Claude Code plugin that enables seamless switching between personal and corporate Claude Code profiles with automatic settings synchronization.

## Package Contents

```
claude-profile-switcher-plugin/
├── manifest.json                      # Plugin metadata and configuration
├── README.md                          # User-facing documentation
├── INSTALLATION.md                    # Detailed installation guide
├── CONTRIBUTING.md                    # Contributor guidelines
├── DISTRIBUTION.md                    # How to share and distribute
├── LICENSE                            # MIT License
├── .gitignore                         # Git ignore rules
├── validate.sh                        # Plugin validation script
├── commands/                          # Claude Code slash commands
│   ├── switch-personal.md            # Switch to personal profile
│   ├── switch-corporate.md           # Switch to corporate profile
│   ├── profile-setup.md              # Initial configuration wizard
│   └── profile-status.md             # Display current status
└── scripts/                           # Shell script templates
    ├── switch-personal-template.sh   # Personal profile switcher
    └── switch-corporate-template.sh  # Corporate profile switcher
```

## Key Features

1. **Seamless Profile Switching**
   - One command to switch between personal and corporate
   - Automatic backup before switching
   - Preserves authentication tokens

2. **Intelligent Settings Sync**
   - Automatically merges enabled plugins across profiles
   - Syncs MCP servers between profiles
   - Configurable sync options

3. **Flexible Configuration**
   - Works with any corporate gateway setup
   - Customizable npm registry switching
   - Template-based for easy organization deployment

4. **Production Ready**
   - Comprehensive documentation
   - Validation script included
   - Error handling and user feedback
   - Cross-platform support (Linux, macOS, WSL)

## Slash Commands

- `/switch-personal` - Switch to personal Claude profile
- `/switch-corporate` - Switch to corporate Claude profile
- `/profile-setup` - Configure the plugin for your organization
- `/profile-status` - View current profile and settings

## How It Works

### Before Switching
```
Current: Corporate Profile
├── settings.json (corporate)
├── tokens/ (corporate SSO)
└── npm (corporate registry)
```

### After `/switch-personal`
```
1. Backup corporate settings to profiles/corporate-settings.json
2. Sync plugins and MCP servers between profiles
3. Copy personal-settings.json to settings.json
4. Restore personal tokens
5. Switch npm to public registry

Result: Personal Profile
├── settings.json (personal)
├── tokens/ (personal auth)
└── npm (public registry)
```

## Configuration Example

```json
{
  "corporateGatewayUrl": "https://live.ai.epicgames.com",
  "corporateNpmRegistry": "https://artifacts.ol.epicgames.net/artifactory/api/npm/npm-all/",
  "apiKeyHelperPath": "/path/to/claude-gateway-helper/dist/jwt-token-helper.js",
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

## Distribution Options

### 1. GitHub Repository
```bash
git clone https://github.com/YOUR_USERNAME/claude-profile-switcher.git
# Follow INSTALLATION.md
```

### 2. Future: Claude Code Marketplace
```bash
claude plugin install profile-switcher
```

### 3. Organization Internal Deployment
- Pre-configured for your company
- Automated deployment via Ansible/Chef/Puppet
- Included in developer onboarding

## Use Cases

### Individual Developers
- Separate personal and work Claude usage
- Different billing accounts
- Keep plugins synced automatically

### Organizations
- Standardize profile switching across teams
- Enforce corporate gateway usage
- Share configuration templates

### Epic Games Example
This plugin was developed to solve a real-world need:
- Corporate: Epic Games SSO + Artifactory npm
- Personal: Direct Anthropic auth + public npm
- Seamless switching without losing settings

## Technical Highlights

1. **Smart Profile Detection**
   - Detects current profile by checking for `apiKeyHelper` in settings
   - Automatically backs up to correct profile

2. **Settings Merge Strategy**
   - Takes union of plugins (both profiles get all plugins)
   - Takes union of MCP servers (both get all servers)
   - Preserves profile-specific settings (apiKeyHelper, etc.)

3. **Token Management**
   - Backs up tokens to profile-specific directories
   - Restores on switch
   - No re-authentication needed

4. **npm Registry Switching**
   - Configurable commands per profile
   - Backs up .npmrc
   - Supports custom registries

## Validation

Run `bash validate.sh` to verify:
- All required files present
- Valid manifest.json
- Scripts are executable
- Commands are complete

## Next Steps

1. **For Sharing Publicly:**
   - Create GitHub repository
   - Add demo GIF/video
   - Write blog post
   - Submit to Claude Code community

2. **For Organization Use:**
   - Create organization-specific config template
   - Document your corporate setup
   - Add to developer onboarding
   - Share with team

3. **For Further Development:**
   - Add more slash commands (e.g., /profile-backup, /profile-restore)
   - Create web UI for configuration
   - Add telemetry (opt-in)
   - Support for more than 2 profiles

## Credits

**Original Use Case:** Epic Games corporate/personal profile switching
**Author:** Darsh Shah
**License:** MIT
**Status:** Production Ready

## Links

- **Installation Guide:** See INSTALLATION.md
- **User Guide:** See README.md
- **Distribution:** See DISTRIBUTION.md
- **Contributing:** See CONTRIBUTING.md

---

**Ready to share with the world!**

This plugin solves a real problem and could help many developers who work with both corporate and personal Claude Code setups. The generalized design makes it adaptable to any organization's infrastructure.
