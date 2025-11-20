# Switch to Corporate Profile

Execute the profile switcher script to switch to your corporate Claude Code profile.

## Instructions

1. Run the profile switcher script located at `~/.claude/plugins/profile-switcher/scripts/switch-corporate.sh`
2. The script will:
   - Backup current settings to the active profile
   - Sync common settings between profiles
   - Switch to corporate gateway authentication
   - Configure npm for corporate registry
3. Display a summary of the switch
4. If authentication is needed, prompt the user about corporate SSO

## Script Execution

Use the Bash tool to execute:

```bash
bash ~/.claude/plugins/profile-switcher/scripts/switch-corporate.sh
```

If the script doesn't exist, inform the user to run `/profile-setup` first to initialize the profile switcher.
