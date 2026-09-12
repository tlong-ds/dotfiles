# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autocomplete
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Direnv hook
eval "$(direnv hook zsh)"

# Docker CLI completions
if [[ -d "/Users/bunnypro/.docker/completions" ]]; then
  fpath=(/Users/bunnypro/.docker/completions $fpath)
fi

# Antigravity CLI
if [[ -d "/Users/bunnypro/.gemini/antigravity-cli/bin" ]]; then
  export PATH="/Users/bunnypro/.gemini/antigravity-cli/bin:$PATH"
fi

alias k=kubectl

export MLOPS="$HOME/Learn/mlops/course-files"

# NVM (Node Version Manager) Lazy Loader
export NVM_DIR="$HOME/.nvm"
function nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}
function node() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; node "$@" }
function npm() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npm "$@" }
function npx() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npx "$@" }
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export N8N_RUNNERS_TASK_BROKER_URI=localhost:5679
export N8N_RUNNERS_AUTH_TOKEN=mySecretToken123

# Default editor and Vi keybindings
export EDITOR=nvim
set -o vi

# User local binaries (uv, uv-installed tools, etc.)
export PATH="/Users/bunnypro/.local/bin:$PATH"

# OpenJDK 17
if [[ -d "/opt/homebrew/opt/openjdk@17" ]]; then
  export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
fi
