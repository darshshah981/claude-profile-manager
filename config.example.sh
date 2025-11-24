#!/bin/bash
# claude-switch configuration
# Copy this file to ~/.claude/profiles/config.sh and edit as needed
#
# Run: claude-switch init
# Or manually: cp config.example.sh ~/.claude/profiles/config.sh

# ============================================================================
# PROFILE NAMES
# ============================================================================
# Customize the names of your profiles. These are used in commands and output.
# Example: claude-switch work, claude-switch home

PERSONAL_PROFILE_NAME="personal"
CORPORATE_PROFILE_NAME="corporate"

# ============================================================================
# CORPORATE GATEWAY SETTINGS
# ============================================================================
# Configure these if your company uses an AI gateway for Claude access.
# Leave empty if you access Anthropic directly for corporate use.

# Your corporate AI gateway URL
# Examples:
#   CORPORATE_GATEWAY_URL="https://ai-gateway.yourcompany.com"
#   CORPORATE_GATEWAY_URL="https://portkey.yourcompany.com/v1"
CORPORATE_GATEWAY_URL=""

# Gateway provider name (for display purposes)
# Examples: "portkey", "aws-bedrock", "azure-openai", "litellm"
CORPORATE_GATEWAY_NAME=""

# SSO provider for authentication (for display purposes)
# Examples: "okta", "azure-ad", "google", "onelogin"
CORPORATE_SSO_PROVIDER=""

# ============================================================================
# NPM REGISTRY SETTINGS
# ============================================================================
# Configure these if your company uses a private npm registry.
# Many enterprises use Artifactory, Nexus, or similar for:
#   - Internal packages
#   - Security scanning
#   - Caching public packages

# Corporate npm registry URL (leave empty to skip npm switching)
# Examples:
#   CORPORATE_NPM_REGISTRY="https://artifactory.yourcompany.com/api/npm/npm-all/"
#   CORPORATE_NPM_REGISTRY="https://nexus.yourcompany.com/repository/npm-group/"
CORPORATE_NPM_REGISTRY=""

# Optional: npm scope for corporate packages
# If your company publishes packages under a scope like @yourcompany
# Example: CORPORATE_NPM_SCOPE="@yourcompany"
CORPORATE_NPM_SCOPE=""

# ============================================================================
# FEATURE FLAGS
# ============================================================================
# Enable or disable specific features. Set to true or false.

# Sync plugins between profiles
# When true, plugins installed in one profile are available in the other
# Recommended: true
SYNC_PLUGINS=true

# Sync MCP servers between profiles
# When true, MCP server configurations are shared across profiles
# Recommended: true
SYNC_MCP_SERVERS=true

# Switch npm registry when changing profiles
# When true, npm registry is switched along with Claude profile
# Set to true if you have a corporate npm registry
SWITCH_NPM_REGISTRY=false

# Backup and restore authentication tokens
# When true, SSO/OAuth tokens are preserved when switching
# Recommended: true
BACKUP_TOKENS=true

# ============================================================================
# DETECTION PATTERNS
# ============================================================================
# How claude-switch determines which profile is currently active.

# Pattern in settings.json that indicates corporate profile
# The script checks if this pattern exists in ~/.claude/settings.json
# Default looks for apiKeyHelper which is set when using a gateway
CORPORATE_DETECTION_PATTERN="apiKeyHelper"

# Pattern in npm registry URL that indicates corporate registry
# Used to detect current npm configuration
# Examples: "artifactory", "nexus", "yourcompany"
CORPORATE_NPM_PATTERN=""
