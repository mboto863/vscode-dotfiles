#!/usr/bin/env bash
set -e

DISTRO=$(grep ^ID= /etc/os-release | cut -d= -f2)

install_packages() {
  case $DISTRO in
    ubuntu|debian)
      sudo apt update
      xargs -a packages/apt.txt sudo apt install -y
      ;;
    fedora)
      sudo dnf update
      xargs -a packages/dnf.txt sudo dnf install -y
      ;;
    *)
      echo "Unsupported distro"
      ;;
    esac
}

install_packages

# Install starship with curl
sudo curl -sS https://starship.rs/install.sh | sh

# VS Code extensions
if command -v code >/dev/null; then
  xargs -L 1 code --install-extension < vscode/extensions.txt
fi

# Symlinks

# ----------------------------------------------------
# Only if personal setup.
# ln -sf ~/vscode-dotfiles/git/.gitconfig ~/.gitconfig
# ----------------------------------------------------

ln -sf ~/vscode-dotfiles/shell/.zshrc ~/.zshrc

mkdir -p ~/.config
ln -sf ~/vscode-dotfiles/config/starship.toml ~/.config/starship.toml

ln -sf ~/vscode-dotfiles/vscode/settings.json \
  ~/.config/Code/User/settings.json

