# Profile Switcher Setup

Guide the user through configuring the profile switcher for their organization.

## Setup Steps

1. **Gather Configuration Information**

   Ask the user for:
   - Corporate gateway URL (if applicable)
     - Example: "https://live.ai.epicgames.com"
     - Leave empty if not using corporate gateway

   - API key helper path (if using corporate SSO)
     - Example: "/path/to/claude-gateway-helper/dist/jwt-token-helper.js"
     - Leave empty if not applicable

   - Corporate npm registry URL (if applicable)
     - Example: "https://artifacts.ol.epicgames.net/artifactory/api/npm/npm-all/"
     - Leave empty to use default npm registry

   - Settings to sync (choose from):
     - enabledPlugins (recommended)
     - mcpServers (recommended)
     - alwaysThinkingEnabled (optional)

2. **Create Configuration File**

   Create `~/.claude/profiles/profile-switcher-config.json` with the gathered information:

   ```json
   {
     "corporateGatewayUrl": "<gateway-url>",
     "apiKeyHelperPath": "<helper-path>",
     "corporateNpmRegistry": "<npm-registry>",
     "syncSettings": ["enabledPlugins", "mcpServers"]
   }
   ```

3. **Generate Switcher Scripts**

   Use the configuration to generate two scripts:
   - `~/.claude/plugins/profile-switcher/scripts/switch-personal.sh`
   - `~/.claude/plugins/profile-switcher/scripts/switch-corporate.sh`

   Base the scripts on the templates in the plugin directory, customizing:
   - Gateway URL
   - npm registry commands
   - API key helper path
   - Settings sync list

4. **Create Profile Directories**

   Ensure these directories exist:
   ```bash
   mkdir -p ~/.claude/profiles/tokens-personal
   mkdir -p ~/.claude/profiles/tokens-corporate
   ```

5. **Initialize Profile Files**

   If they don't exist, create:
   - `~/.claude/profiles/personal-settings.json` (copy from current settings.json if in personal mode)
   - `~/.claude/profiles/corporate-settings.json` (create minimal template)

6. **Make Scripts Executable**

   ```bash
   chmod +x ~/.claude/plugins/profile-switcher/scripts/*.sh
   ```

7. **Create Convenience Aliases** (Optional)

   Offer to add aliases to `~/.bashrc` or `~/.zshrc`:
   ```bash
   alias switch-personal='bash ~/.claude/plugins/profile-switcher/scripts/switch-personal.sh'
   alias switch-corporate='bash ~/.claude/plugins/profile-switcher/scripts/switch-corporate.sh'
   ```

8. **Test the Setup**

   Run `/profile-status` to verify configuration

## Success Message

Display:
```
Profile Switcher setup complete!

You can now use:
- /switch-personal  - Switch to personal profile
- /switch-corporate - Switch to corporate profile
- /profile-status   - Check current profile

Configuration saved to: ~/.claude/profiles/profile-switcher-config.json
Scripts installed to: ~/.claude/plugins/profile-switcher/scripts/
```
