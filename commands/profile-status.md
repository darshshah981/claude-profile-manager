# Profile Status

Display information about the current Claude Code profile and configuration.

## Instructions

1. **Detect Current Profile**
   - Read `~/.claude/settings.json`
   - Check for presence of `apiKeyHelper` field:
     - If present: Corporate profile is active
     - If absent: Personal profile is active

2. **Display Current Configuration**

   Show:
   - **Active Profile**: Personal or Corporate
   - **Enabled Plugins**: List all enabled plugins from settings.json
   - **MCP Servers**: List all configured MCP servers
   - **npm Registry**: Run `npm config get registry` to show current registry
   - **Always Thinking**: Value of `alwaysThinkingEnabled`

3. **Show Profile Switcher Configuration**

   Read `~/.claude/profiles/profile-switcher-config.json` and display:
   - Corporate gateway URL (if configured)
   - Corporate npm registry (if configured)
   - Settings being synced

4. **Check Profile Files Status**

   Verify and display:
   - `~/.claude/profiles/personal-settings.json` exists and last modified time
   - `~/.claude/profiles/corporate-settings.json` exists and last modified time
   - Token backup directories exist

## Output Format

```
========================================
Profile Switcher Status
========================================

Active Profile: [Personal/Corporate]

Current Settings:
  - Enabled Plugins:
    * commit-commands@claude-code-plugins
    * feature-dev@claude-code-plugins
    * frontend-design@claude-code-plugins
    * explanatory-output-style@claude-code-plugins

  - MCP Servers:
    * firecrawl

  - npm Registry: [registry URL]
  - Always Thinking: [true/false]

Profile Switcher Configuration:
  - Corporate Gateway: [URL or "Not configured"]
  - Corporate npm: [URL or "Not configured"]
  - Synced Settings: [list]

Profile Backups:
  - Personal: Last updated [date/time]
  - Corporate: Last updated [date/time]

Use /switch-personal or /switch-corporate to switch profiles.
```
