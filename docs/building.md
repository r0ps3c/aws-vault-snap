# Building AWS Vault Snap

## Prerequisites

### Install Snapcraft

```bash
sudo snap install snapcraft --classic
```

### Install Build Environment

Snapcraft requires an isolated build environment. This snap assumes/uses multipass. See https://documentation.ubuntu.com/snapcraft/stable/how-to/set-up-snapcraft/ for more details

## Build Methods

**Build:**
```bash
make build
# or
SNAPCRAFT_BUILD_ENVIRONMENT=multipass snapcraft pack
```

## Build Artifacts

```
parts/          # Build artifacts (auto-cleaned)
stage/          # Staged files (auto-cleaned)
prime/          # Final snap contents (auto-cleaned)
*.snap          # Built snap package (keep this)
```

## Clean Builds

```bash
# Clean snap build artifacts
make clean
# or
snapcraft clean

# Full clean including Multipass VMs
make clean-all
```

## CI/CD Builds

GitHub Actions uses `snapcore/action-build` which handles the build environment internally. See `.github/workflows/snap.yml`.
