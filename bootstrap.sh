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

# VS Code extensions
if command -v code >/dev/null; then
  xargs -L 1 code --install-extension < vscode/extensions.txt
fi

# Symlinks
ln -sf ~/vscode-dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/vscode-dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/vscode-dotfiles/vscode/settings.json \
    ~/.config/Code/User/settings.json
ln -sf ~/vscode-dotfiles/vscode/keybindings.json \
    ~/.config/Code/User/keybindings.json

mkdir -p ~/.config
ln -sf ~/vscode-dotfiles/config/starship.toml ~/.config/startship.toml
