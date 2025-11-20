# Switch to Personal Profile

Execute the profile switcher script to switch to your personal Claude Code profile.

## Instructions

1. Run the profile switcher script located at `~/.claude/plugins/profile-switcher/scripts/switch-personal.sh`
2. The script will:
   - Backup current settings to the active profile
   - Sync common settings between profiles
   - Switch to personal authentication
   - Configure npm for public registry
3. Display a summary of the switch
4. If authentication is needed, prompt the user to run `claude logout && claude login`

## Script Execution

Use the Bash tool to execute:

```bash
bash ~/.claude/plugins/profile-switcher/scripts/switch-personal.sh
```

If the script doesn't exist, inform the user to run `/profile-setup` first to initialize the profile switcher.
