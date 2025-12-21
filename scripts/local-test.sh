#!/bin/bash
# Local testing script for aws-vault snap

set -e

echo "=== AWS Vault Snap Local Test ==="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Find the snap file
SNAP_FILE=$(ls -t *.snap 2>/dev/null | head -n1)

if [ -z "$SNAP_FILE" ]; then
    echo -e "${RED}Error: No snap file found. Run 'make build' first.${NC}"
    exit 1
fi

echo -e "${GREEN}Found snap: $SNAP_FILE${NC}"

# Check if already installed
if snap list aws-vault &>/dev/null; then
    echo -e "${YELLOW}Removing existing aws-vault snap...${NC}"
    sudo snap remove aws-vault
fi

# Install the snap
echo -e "${GREEN}Installing snap...${NC}"
sudo snap install --dangerous --classic "$SNAP_FILE"

# Test version
echo -e "${GREEN}Testing aws-vault version...${NC}"
aws-vault --version

# Test help
echo -e "${GREEN}Testing aws-vault help...${NC}"
aws-vault --help

# Test subcommands
echo -e "${GREEN}Testing subcommand help...${NC}"
aws-vault list --help
aws-vault exec --help
aws-vault add --help

# Success
echo -e "${GREEN}=== All tests passed! ===${NC}"
echo -e "${YELLOW}To remove: sudo snap remove aws-vault${NC}"
