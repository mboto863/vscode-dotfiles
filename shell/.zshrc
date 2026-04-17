export EDITOR="code --wait"
export VISUAL="code --wait"
export ZDOTDIR=$HOME/.config/zsh

source ~/vscode-dotfiles/shell/aliases.sh

# Startship prompt
eval "$(starship init zsh)"

# Better defaults
setopt autocd
setopt correct
