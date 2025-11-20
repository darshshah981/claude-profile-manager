#!/bin/bash
# Validation script for Claude Profile Switcher plugin

echo "Validating Claude Profile Switcher plugin..."
echo ""

ERRORS=0
WARNINGS=0

# Check required files
echo "[1/4] Checking required files..."
REQUIRED_FILES=(
    "manifest.json"
    "README.md"
    "INSTALLATION.md"
    "LICENSE"
    "commands/switch-personal.md"
    "commands/switch-corporate.md"
    "commands/profile-setup.md"
    "commands/profile-status.md"
    "scripts/switch-personal-template.sh"
    "scripts/switch-corporate-template.sh"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  [OK] $file"
    else
        echo "  [ERROR] Missing: $file"
        ((ERRORS++))
    fi
done

echo ""
echo "[2/4] Validating manifest.json..."
if command -v python3 &> /dev/null; then
    python3 << 'PYTHON'
import json
import sys

try:
    with open('manifest.json', 'r') as f:
        manifest = json.load(f)

    # Check required fields
    required = ['name', 'version', 'description', 'commands']
    for field in required:
        if field not in manifest:
            print(f"  [ERROR] Missing field: {field}")
            sys.exit(1)

    # Check commands
    if len(manifest.get('commands', [])) < 4:
        print(f"  [WARNING] Expected at least 4 commands, found {len(manifest['commands'])}")

    print(f"  [OK] Valid manifest.json")
    print(f"       Name: {manifest['name']}")
    print(f"       Version: {manifest['version']}")
    print(f"       Commands: {len(manifest['commands'])}")

except json.JSONDecodeError as e:
    print(f"  [ERROR] Invalid JSON: {e}")
    sys.exit(1)
except Exception as e:
    print(f"  [ERROR] {e}")
    sys.exit(1)
PYTHON
    if [ $? -ne 0 ]; then
        ((ERRORS++))
    fi
else
    echo "  [WARNING] Python3 not found, skipping JSON validation"
    ((WARNINGS++))
fi

echo ""
echo "[3/4] Checking script permissions..."
for script in scripts/*.sh; do
    if [ -x "$script" ]; then
        echo "  [OK] $script is executable"
    else
        echo "  [WARNING] $script is not executable (run: chmod +x $script)"
        ((WARNINGS++))
    fi
done

echo ""
echo "[4/4] Checking command files..."
for cmd in commands/*.md; do
    if [ -f "$cmd" ] && [ -s "$cmd" ]; then
        echo "  [OK] $cmd"
    else
        echo "  [ERROR] $cmd is empty or missing"
        ((ERRORS++))
    fi
done

echo ""
echo "=========================================="
echo "Validation Complete"
echo "=========================================="
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -eq 0 ]; then
    echo "Plugin is ready for distribution!"
    exit 0
else
    echo "Please fix the errors above before distributing."
    exit 1
fi
