# Distribution Guide

This guide explains how to share the Claude Profile Switcher plugin with others.

## Distribution Options

### 1. GitHub Repository (Recommended)

**Steps:**

1. **Create a new GitHub repository**
   ```bash
   # Initialize git if not already done
   cd ~/claude-profile-switcher-plugin
   git init
   git add .
   git commit -m "Initial commit: Claude Profile Switcher plugin"
   ```

2. **Create repository on GitHub**
   - Go to https://github.com/new
   - Name: `claude-profile-switcher`
   - Description: "Switch between personal and corporate Claude Code profiles with automatic settings sync"
   - Public or Private (your choice)
   - Click "Create repository"

3. **Push to GitHub**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/claude-profile-switcher.git
   git branch -M main
   git push -u origin main
   ```

4. **Users can install from GitHub**
   ```bash
   # Clone and install
   git clone https://github.com/YOUR_USERNAME/claude-profile-switcher.git
   mkdir -p ~/.claude/plugins/marketplaces/custom
   cp -r claude-profile-switcher ~/.claude/plugins/marketplaces/custom/profile-switcher
   chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh

   # Enable in Claude Code
   claude plugin enable profile-switcher@custom
   ```

### 2. Claude Code Marketplace (Future)

Once Claude Code has an official marketplace submission process:

1. **Prepare for submission**
   - Ensure all validation passes: `bash validate.sh`
   - Test on multiple platforms
   - Create screenshots/demos

2. **Submit to marketplace**
   - Follow Claude Code marketplace submission guidelines
   - Provide manifest.json and all required files

3. **Users can install via CLI**
   ```bash
   claude plugin install profile-switcher
   ```

### 3. Internal Organization Distribution

For companies wanting to deploy to their teams:

#### Option A: Internal Package Registry

1. **Create organization-specific config**
   ```bash
   # Create templates directory
   mkdir -p templates/your-org
   ```

2. **Add your org's default config**
   Create `templates/your-org/config.json`:
   ```json
   {
     "corporateGatewayUrl": "https://your-company.com/claude-gateway",
     "corporateNpmRegistry": "https://your-npm.com/registry/",
     "apiKeyHelperPath": "/standard/path/to/helper.js",
     "syncSettings": ["enabledPlugins", "mcpServers"]
   }
   ```

3. **Create installation script**
   Create `templates/your-org/install.sh`:
   ```bash
   #!/bin/bash
   PLUGIN_DIR="$HOME/.claude/plugins/marketplaces/custom/profile-switcher"

   # Install plugin
   mkdir -p "$PLUGIN_DIR"
   cp -r . "$PLUGIN_DIR/"

   # Install org config
   mkdir -p "$HOME/.claude/profiles"
   cp templates/your-org/config.json "$HOME/.claude/profiles/profile-switcher-config.json"

   # Make executable
   chmod +x "$PLUGIN_DIR/scripts/"*.sh

   echo "Claude Profile Switcher installed for YOUR_ORG"
   echo "Run 'claude plugin enable profile-switcher@custom' to enable"
   ```

4. **Distribute to team**
   - Host on internal Git server
   - Share via internal package manager
   - Include in developer onboarding docs

#### Option B: Chef/Puppet/Ansible Automation

Example Ansible playbook:

```yaml
---
- name: Install Claude Profile Switcher
  hosts: developer_machines
  tasks:
    - name: Clone plugin repository
      git:
        repo: 'https://github.com/your-org/claude-profile-switcher.git'
        dest: '/tmp/claude-profile-switcher'

    - name: Create plugin directory
      file:
        path: '{{ ansible_env.HOME }}/.claude/plugins/marketplaces/custom/profile-switcher'
        state: directory
        mode: '0755'

    - name: Copy plugin files
      copy:
        src: '/tmp/claude-profile-switcher/'
        dest: '{{ ansible_env.HOME }}/.claude/plugins/marketplaces/custom/profile-switcher/'
        mode: '0755'

    - name: Copy org config
      template:
        src: 'org-config.json.j2'
        dest: '{{ ansible_env.HOME }}/.claude/profiles/profile-switcher-config.json'

    - name: Make scripts executable
      file:
        path: '{{ ansible_env.HOME }}/.claude/plugins/marketplaces/custom/profile-switcher/scripts/{{ item }}'
        mode: '0755'
      with_items:
        - switch-personal-template.sh
        - switch-corporate-template.sh
```

### 4. Direct Distribution (Tarball)

For simple sharing:

1. **Create distributable package**
   ```bash
   cd ~
   tar -czf claude-profile-switcher-v1.0.0.tar.gz claude-profile-switcher-plugin/

   # Or with specific name
   tar -czf claude-profile-switcher-v1.0.0.tar.gz \
     --transform 's/claude-profile-switcher-plugin/profile-switcher/' \
     claude-profile-switcher-plugin/
   ```

2. **Share the tarball**
   - Upload to file sharing service
   - Attach to email
   - Host on internal server

3. **Users install with**
   ```bash
   # Extract
   tar -xzf claude-profile-switcher-v1.0.0.tar.gz

   # Install
   mkdir -p ~/.claude/plugins/marketplaces/custom
   cp -r profile-switcher ~/.claude/plugins/marketplaces/custom/
   chmod +x ~/.claude/plugins/marketplaces/custom/profile-switcher/scripts/*.sh

   # Enable
   claude plugin enable profile-switcher@custom
   ```

## Release Process

### Versioning

Follow semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes (e.g., 2.0.0)
- **MINOR**: New features (e.g., 1.1.0)
- **PATCH**: Bug fixes (e.g., 1.0.1)

### Creating a Release

1. **Update version in manifest.json**
   ```json
   {
     "version": "1.1.0"
   }
   ```

2. **Create CHANGELOG**
   ```markdown
   ## [1.1.0] - 2025-01-20

   ### Added
   - New feature X
   - Support for Y

   ### Fixed
   - Bug in Z
   ```

3. **Tag and release**
   ```bash
   git add manifest.json CHANGELOG.md
   git commit -m "Release v1.1.0"
   git tag -a v1.1.0 -m "Version 1.1.0"
   git push origin main --tags
   ```

4. **Create GitHub release**
   - Go to Releases on GitHub
   - Click "Create a new release"
   - Select tag v1.1.0
   - Add release notes
   - Attach tarball as asset

## Marketing and Visibility

### README Badge

Add to your GitHub README:

```markdown
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue)](https://github.com/YOUR_USERNAME/claude-profile-switcher)
[![Version](https://img.shields.io/badge/version-1.0.0-green)](https://github.com/YOUR_USERNAME/claude-profile-switcher/releases)
```

### Community Sharing

1. **Share on relevant platforms**
   - Claude Code community forums
   - Reddit r/ClaudeAI
   - Hacker News
   - Dev.to article

2. **Create demo video/GIF**
   - Show installation process
   - Demonstrate profile switching
   - Highlight settings sync

3. **Write blog post**
   - Problem it solves
   - How it works
   - Real-world use cases

### Documentation

Ensure these are clear and complete:
- README.md - Overview and quick start
- INSTALLATION.md - Detailed installation guide
- CONTRIBUTING.md - How to contribute
- CHANGELOG.md - Version history

## Support

### Issue Template

Create `.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
---
name: Bug report
about: Report a bug in Claude Profile Switcher
---

**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce:
1. Run /switch-personal
2. ...

**Expected behavior**
What you expected to happen.

**Environment:**
 - OS: [e.g. Ubuntu 22.04, macOS 14]
 - Claude Code version: [e.g. 1.0.0]
 - Python version: [e.g. 3.10]

**Configuration:**
Paste your `~/.claude/profiles/profile-switcher-config.json` (remove secrets)
```

### Feature Request Template

Create `.github/ISSUE_TEMPLATE/feature_request.md`

## Metrics and Analytics

Track adoption:
- GitHub stars
- Download counts
- Issue resolution time
- Community contributions

## License

Ensure LICENSE file is included. MIT is recommended for maximum adoption.

## Next Steps

1. Choose your distribution method
2. Test installation on clean system
3. Create documentation
4. Announce to community
5. Monitor feedback and iterate
