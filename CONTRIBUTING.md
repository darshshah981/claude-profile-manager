# Contributing Guide

Thank you for your interest in contributing to Claude Profile Switcher!

## Ways to Contribute

1. **Bug Reports**: Found a bug? Open an issue with details
2. **Feature Requests**: Have an idea? Share it via issues
3. **Code Contributions**: Submit pull requests
4. **Documentation**: Help improve docs
5. **Organization Templates**: Share your corporate setup configs

## Development Setup

### Prerequisites

- Claude Code installed
- Python 3.6+
- Git
- Bash/Zsh shell

### Fork and Clone

```bash
# Fork on GitHub first, then:
git clone https://github.com/YOUR_USERNAME/claude-profile-switcher.git
cd claude-profile-switcher
```

### Install for Development

```bash
# Link to plugins directory for testing
ln -s $(pwd) ~/.claude/plugins/marketplaces/custom/profile-switcher

# Make scripts executable
chmod +x scripts/*.sh

# Enable in Claude Code
claude plugin enable profile-switcher@custom
```

### Testing Your Changes

1. Make your changes to the code
2. Test with both profiles:
   ```
   /switch-personal
   /profile-status
   /switch-corporate
   /profile-status
   ```
3. Verify settings sync correctly
4. Check error handling

## Code Structure

```
claude-profile-switcher/
├── manifest.json                 # Plugin metadata and command definitions
├── README.md                     # User documentation
├── INSTALLATION.md               # Installation guide
├── CONTRIBUTING.md               # This file
├── commands/                     # Slash command prompts
│   ├── switch-personal.md       # Personal profile switch prompt
│   ├── switch-corporate.md      # Corporate profile switch prompt
│   ├── profile-setup.md         # Setup wizard prompt
│   └── profile-status.md        # Status display prompt
└── scripts/                      # Shell script templates
    ├── switch-personal-template.sh   # Personal switch script
    └── switch-corporate-template.sh  # Corporate switch script
```

## Command Prompts

Commands in `/commands/` are markdown files that Claude Code reads and executes. They should:

- Be clear and actionable
- Handle errors gracefully
- Provide helpful feedback to users
- Follow the existing style

### Example Command Structure

```markdown
# Command Title

Brief description of what this command does.

## Instructions

1. Step-by-step instructions for Claude to follow
2. Use Bash tool for shell commands
3. Use file operations for reading/writing
4. Provide user feedback

## Error Handling

- Check prerequisites
- Validate inputs
- Provide helpful error messages
```

## Shell Scripts

The template scripts in `/scripts/` are generated during setup. They should:

- Be POSIX-compliant when possible
- Use configuration from `profile-switcher-config.json`
- Handle missing dependencies gracefully
- Provide clear output

### Script Guidelines

1. **Always check for required tools**
   ```bash
   if ! command -v python3 &> /dev/null; then
       echo "Python3 required but not found"
       exit 1
   fi
   ```

2. **Use configuration files**
   ```bash
   CONFIG_FILE="$PROFILES_DIR/profile-switcher-config.json"
   if [ -f "$CONFIG_FILE" ]; then
       # Load settings
   fi
   ```

3. **Provide helpful output**
   ```bash
   echo "[1/3] Backing up settings..."
   echo "  - Backed up to: $BACKUP_PATH"
   ```

## Adding New Features

### New Configuration Option

1. Add to `manifest.json` settings schema:
   ```json
   "newOption": {
     "type": "string",
     "description": "Description of new option",
     "default": "default-value"
   }
   ```

2. Update script templates to use it:
   ```bash
   NEW_OPTION=$(python3 -c "import json; config=json.load(open('$CONFIG_FILE')); print(config.get('newOption', ''))")
   ```

3. Document in README.md

### New Slash Command

1. Create markdown file in `commands/`:
   ```bash
   touch commands/new-command.md
   ```

2. Add to `manifest.json`:
   ```json
   {
     "name": "new-command",
     "description": "What this command does",
     "file": "commands/new-command.md"
   }
   ```

3. Write the command prompt
4. Test thoroughly
5. Document in README.md

## Testing Checklist

Before submitting a PR, verify:

- [ ] Scripts are executable (`chmod +x`)
- [ ] Works on fresh installation
- [ ] Settings sync correctly
- [ ] Tokens are preserved
- [ ] npm registry switches work
- [ ] Error messages are helpful
- [ ] Documentation is updated
- [ ] No hardcoded paths (except standard locations)
- [ ] Python fallbacks work if Python not available
- [ ] Works on Linux and macOS (and WSL for Windows)

## Submitting Pull Requests

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write clean, commented code
   - Follow existing code style
   - Add tests if applicable

3. **Commit with clear messages**
   ```bash
   git commit -m "Add feature: description of what you added"
   ```

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Open a Pull Request**
   - Describe what changed and why
   - Reference any related issues
   - Include testing notes

## Organization Templates

If you've set up this plugin for your organization, consider sharing your configuration template!

1. Create a sanitized version (remove secrets):
   ```json
   {
     "corporateGatewayUrl": "https://your-org.com",
     "corporateNpmRegistry": "https://your-registry.com/npm/",
     "apiKeyHelperPath": "/path/to/helper.js",
     "syncSettings": ["enabledPlugins", "mcpServers"]
   }
   ```

2. Submit as PR to `templates/organizations/`
3. Include setup instructions specific to your org

## Code Style

### Bash Scripts
- Use 2-space indentation
- Quote all variables: `"$VAR"`
- Check command success: `command || { echo "failed"; exit 1; }`
- Use `#!/bin/bash` shebang

### Python Scripts
- Follow PEP 8
- Use f-strings for formatting
- Handle exceptions gracefully

### Markdown
- Use ATX-style headers (`#`)
- Include code examples in fenced blocks
- Keep line length reasonable

## Getting Help

- Questions: Open a GitHub Discussion
- Bugs: Open an Issue
- Security: Email security@your-org.com

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
