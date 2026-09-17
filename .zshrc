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
  fzf
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Ensure clean fpath
fpath=(${fpath:#*zsh-autocomplete*})

source $ZSH/oh-my-zsh.sh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf-tab styling & settings
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:down' 'ctrl-k:up'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Remove right prompt from past lines to prevent reflow artifacts on window resize
setopt transient_rprompt

# Redraw prompt cleanly on window resize
TRAPWINCH() {
  if [[ -o zle ]]; then
    zle reset-prompt
    zle -R
  fi
}

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
alias v=nvim

export MLOPS="$HOME/Learn/mlops/course-files"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR/versions/node" ]]; then
  local nvm_default=$(<"$NVM_DIR/alias/default" 2>/dev/null)
  [[ -n "$nvm_default" && -d "$NVM_DIR/versions/node/$nvm_default/bin" ]] && \
    export PATH="$NVM_DIR/versions/node/$nvm_default/bin:$PATH"
fi

function nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export N8N_RUNNERS_TASK_BROKER_URI=localhost:5679
export N8N_RUNNERS_AUTH_TOKEN=mySecretToken123

# Default editor and Vi keybindings
export EDITOR=nvim
set -o vi
export KEYTIMEOUT=15

# Vi keybindings: Autosuggestions & FZF
bindkey -M viins '^f' autosuggest-accept
bindkey -M viins '^ ' autosuggest-accept
bindkey -M viins '^e' forward-word
bindkey -M viins '^r' fzf-history-widget
bindkey -M viins '^t' fzf-file-widget
bindkey -M vicmd '^r' fzf-history-widget
bindkey -M vicmd '^t' fzf-file-widget

# User local binaries (uv, uv-installed tools, etc.)
export PATH="/Users/bunnypro/.local/bin:$PATH"

# OpenJDK 17
if [[ -d "/opt/homebrew/opt/openjdk@17" ]]; then
  export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
fi
