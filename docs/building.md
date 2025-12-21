# Building AWS Vault Snap

## Prerequisites

### Install Snapcraft

```bash
sudo snap install snapcraft --classic
```

### Install Build Environment (Choose One)

Snapcraft requires an isolated build environment. You have two options:

#### Option 1: Multipass (Recommended, Cross-Platform)

**Ubuntu/Debian:**
```bash
sudo snap install multipass
# or
make setup-multipass
```

**macOS:**
```bash
brew install multipass
```

**Windows:**
Download from https://multipass.run/download/windows

**Verify:**
```bash
multipass version
```

#### Option 2: LXD (Linux Only, Faster)

**Ubuntu/Debian:**
```bash
sudo snap install lxd
sudo lxd init --auto
sudo usermod -a -G lxd $USER
# Log out and back in for group changes
# or
make setup-lxd
```

**Verify:**
```bash
lxd version
```

**Which to choose?**
- **Multipass**: Works on Linux, macOS, Windows. Slightly slower but more compatible.
- **LXD**: Linux only. Faster builds but requires more setup.

## Quick Build

```bash
# Build snap (Multipass handles the VM automatically)
make build

# Or directly:
snapcraft
```

**What happens:**
1. Snapcraft creates a Multipass VM
2. VM downloads Ubuntu 22.04 (core22 base)
3. Clones aws-vault source from GitHub
4. Runs tests (`go test ./...`)
5. Builds the binary
6. Creates the .snap file
7. VM is cached for faster subsequent builds

**First build:** ~5-10 minutes (downloads VM image)
**Subsequent builds:** ~2-5 minutes (uses cached VM)

## Build Methods

### Method 1: Multipass (Default, Cross-Platform)

**Build:**
```bash
make build
# or
SNAPCRAFT_BUILD_ENVIRONMENT=multipass snapcraft pack
```

**Advantages:**
- Works on Linux, macOS, Windows
- Isolated environment (no host pollution)
- Reliable and well-tested

**Build time:**
- First build: ~5-10 minutes (downloads VM image)
- Subsequent builds: ~2-5 minutes (cached VM)

### Method 2: LXD (Linux Only, Faster)

**Build:**
```bash
make build-lxd
# or
SNAPCRAFT_BUILD_ENVIRONMENT=lxd snapcraft pack
```

**Advantages:**
- Faster than Multipass (container vs VM)
- Less overhead
- Still fully isolated

**Build time:**
- First build: ~3-7 minutes
- Subsequent builds: ~1-3 minutes

**Requirements:**
- Linux only
- LXD must be installed and configured

## Troubleshooting

### Multipass Won't Start

**Issue:** VM fails to start

**Solutions:**
```bash
# Check Multipass status
multipass list

# Delete and rebuild
snapcraft clean
multipass delete snapcraft-aws-vault
multipass purge

# Rebuild
snapcraft
```

### Out of Disk Space

```bash
# Clean build artifacts
make clean

# Clean everything including VMs
make clean-all
```

### Build Fails in VM

```bash
# Shell into the VM for debugging
snapcraft --shell

# Or shell after failure
snapcraft --shell-after

# Manually inspect
multipass shell snapcraft-aws-vault
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
