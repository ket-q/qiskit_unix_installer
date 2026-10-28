# Quantum Computing Environment Setup

> [!NOTE]
> This repository is for Linux and macOS.
> If you work on Windows, please use [QIWI](https://github.com/ket-q/qiskit_windows_installer).

Scripts to set up Qiskit for your quantum computer programming course on Linux and macOS.

## Installation
Depending on whether you have Git installed on your computer, please
proceed with one of the two following installation instructions.
### With Git
Open your terminal (Terminal app on macOS, or your preferred shell on Linux) and run the following commands:

```bash
# 1. Clone the repository
git clone https://github.com/ket-q/qiskit_unix_installer

# 2. Navigate into the directory
cd qiskit_unix_installer

# 3. Run the setup script
bash setup.sh
```

### Without Git
Open a terminal.
* On macOS, press ``cmd`` + ``space`` , type ``Terminal``, and press ``Return``.
* On Linux, open the terminal application of your desktop environment (often ``ctrl`` + ``alt`` + ``T``).

Copy-paste the following commands into your terminal, which downloads version v1.0 of the qiskit_unix_installer into your home folder and
performs the installation.
```bash
TAG=v1.0
REPO=https://github.com/ket-q/qiskit_unix_installer
DIR="qiskit_unix_installer_$TAG"
cd ~
mkdir -p "$DIR"
curl -fsSL "$REPO/archive/refs/tags/$TAG.tar.gz" |
tar -xz -C "$DIR" --strip-components=1
cd "$DIR"
bash setup.sh
```

## Uninstallation

If you ever need to completely remove the virtual environment and start fresh, run:

```bash
bash uninstall.sh
```
