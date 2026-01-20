# AWS Vault Snap

Snap package for [aws-vault](https://github.com/ByteNess/aws-vault) - a tool to securely store and access AWS credentials in development environments.

## What is AWS Vault?

AWS Vault stores IAM credentials in your operating system's secure keystore and generates temporary credentials from those long-term keys to expose to your shell and applications. It's designed to be complementary to the AWS CLI tools.

## Installation

### From Snap Store

```bash
sudo snap install roprop-aws-vault --classic
sudo snap alias roprop-aws-vault.aws-vault aws-vault
```

### From Release

Download the latest `.snap` file from the Releases page:

```bash
sudo snap install --dangerous --classic roprop-aws-vault_*.snap
sudo snap alias roprop-aws-vault.aws-vault aws-vault
```

### Build from Source

Quick build with Multipass:

```bash
make build
make install
sudo snap alias roprop-aws-vault.aws-vault aws-vault
```

See [docs/building.md](docs/building.md) for detailed build instructions.


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

For full usage documentation, see the [aws-vault documentation](https://github.com/ByteNess/aws-vault/blob/main/USAGE.md).


## License

This snap packaging is released under the MIT License. The aws-vault software itself maintains its own license (see [upstream repository](https://github.com/ByteNess/aws-vault)).
