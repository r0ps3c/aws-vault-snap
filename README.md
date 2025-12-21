# AWS Vault Snap

Snap package for [aws-vault](https://github.com/ByteNess/aws-vault) - a tool to securely store and access AWS credentials in development environments.

## What is AWS Vault?

AWS Vault stores IAM credentials in your operating system's secure keystore and generates temporary credentials from those long-term keys to expose to your shell and applications. It's designed to be complementary to the AWS CLI tools.

## Installation

### From Release (Recommended)

Download the latest `.snap` file from the Releases page:

```bash
sudo snap install --dangerous --classic aws-vault_*.snap
```

### Build from Source

Quick build with Multipass:

```bash
make build
make install
```

See [docs/building.md](docs/building.md) for detailed build instructions.

## Prerequisites for Building

### Install Multipass

**Ubuntu/Debian:**
```bash
sudo snap install multipass
```

**macOS:**
```bash
brew install multipass
```

**Windows:**
Download from https://multipass.run/download/windows

### Install Snapcraft

```bash
sudo snap install snapcraft --classic
```

## Quick Start

### Build

```bash
make build
```

Or directly:
```bash
snapcraft
```

### Install

```bash
make install
```

### Usage

```bash
# Add credentials
aws-vault add my-profile

# Execute command with temporary credentials
aws-vault exec my-profile -- aws s3 ls

# Start a shell with credentials
aws-vault exec my-profile

# List profiles
aws-vault list
```

For full usage documentation, see the [upstream aws-vault documentation](https://github.com/99designs/aws-vault#usage).

## Features

- **Secure**: Uses OS keychain for credential storage
- **Temporary Credentials**: Generates short-lived credentials
- **MFA Support**: Compatible with MFA-enabled AWS accounts
- **Classic Confinement**: Full system access for keychain integration

## Security

This snap uses `classic` confinement to allow access to system keychains and credential stores. See [SECURITY.md](SECURITY.md) for security considerations.

All builds are scanned with Trivy for vulnerabilities. Security scan results are available in the Security tab.

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

### Quick Start

```bash
# Install pre-commit hooks
pip install pre-commit
pre-commit install

# Build snap
make build

# Run tests
make test

# Lint configuration
make lint
```

## Project Structure

```
.
├── snap/
│   └── snapcraft.yaml      # Snap package configuration
├── .github/
│   ├── workflows/          # CI/CD pipelines
│   └── renovate.json       # Dependency automation
├── docs/                   # Documentation
├── scripts/                # Helper scripts
└── Makefile               # Build automation
```

## Automated Maintenance

This project uses:
- **Renovate**: Automated dependency updates
- **GitHub Actions**: CI/CD automation
- **Trivy**: Security vulnerability scanning
- **Pre-commit**: Code quality checks

## License

This snap packaging is released under the MIT License. The aws-vault software itself maintains its own license (see [upstream repository](https://github.com/99designs/aws-vault)).

## Contributing

Contributions welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

## Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/aws-vault-snap/issues)
- **Upstream**: [aws-vault Issues](https://github.com/99designs/aws-vault/issues)

## Acknowledgments

- [aws-vault](https://github.com/99designs/aws-vault) by 99designs
- [ByteNess fork](https://github.com/ByteNess/aws-vault)
