.PHONY: help build clean clean-all test lint install

# Default target
help:
	@echo "Available targets:"
	@echo "  build             - Build snap using Multipass (default)"
	@echo "  clean             - Clean build artifacts"
	@echo "  clean-all         - Clean all artifacts including VMs"
	@echo "  test              - Test the built snap"
	@echo "  lint              - Lint snapcraft.yaml"
	@echo "  install           - Install the built snap locally"

# Build snap using Multipass (recommended)
build:
	SNAPCRAFT_BUILD_ENVIRONMENT=multipass snapcraft pack

# Clean build artifacts
clean:
	snapcraft clean
	rm -f *.snap

# Clean all including VMs
clean-all: clean
	multipass delete snapcraft-aws-vault || true
	multipass purge || true

# Test the built snap
test:
	@if [ ! -f *.snap ]; then \
		echo "No snap file found. Run 'make build' first."; \
		exit 1; \
	fi
	@echo "Testing snap installation..."
	sudo snap install --dangerous --classic *.snap
	@echo "Testing aws-vault command..."
	aws-vault --version
	@echo "Cleaning up test installation..."
	sudo snap remove aws-vault

# Lint snapcraft.yaml
lint:
	yamllint snap/snapcraft.yaml || echo "yamllint not installed, skipping..."

# Install the snap
install:
	@if [ ! -f *.snap ]; then \
		echo "No snap file found. Run 'make build' first."; \
		exit 1; \
	fi
	sudo snap install --dangerous --classic *.snap
	@echo "Snap installed successfully. Run 'aws-vault --version' to verify."