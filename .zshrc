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
  zsh-autosuggestions
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

export EDITOR=nvim
set -o vi

export NVIM_SYNC_NAME="${NVIM_SYNC_NAME:-main}"

_nvim_sock() {
    print -r -- "${XDG_RUNTIME_DIR:-$HOME/.local/state}/nvim-shell-sync-${NVIM_SYNC_NAME}.sock"
}

nvim-use-session() {
    if [[ -z "$1" ]]; then
        echo "usage: nvim-use-session <name>"
        return 1
    fi
    export NVIM_SYNC_NAME="$1"
    echo "using Neovim session: $NVIM_SYNC_NAME"
}

v() {
    local sock
    sock="$(_nvim_sock)"
    mkdir -p "${sock:h}"
    command nvim --listen "$sock" "$@"
}

# On new shell start, cd to nvim's cwd if a session socket exists.
# Skip when already inside nvim's own :terminal (NVIM is set).
_nvim_inherit_cwd() {
    [[ -n "${NVIM:-}" ]] && return 0          # inside nvim terminal — leave it alone
    local sock nvim_cwd
    sock="$(_nvim_sock)"
    [[ -S "$sock" ]] || return 0              # no active session
    nvim_cwd=$(command nvim --server "$sock" --remote-expr "getcwd()" 2>/dev/null)
    [[ -n "$nvim_cwd" && -d "$nvim_cwd" ]] && cd "$nvim_cwd"
}
_nvim_inherit_cwd

rangdong-start() {
	tmux new -s fastapi_svc -d
	tmux send-keys -t fastapi_svc "uvicorn src.api.api:app --port 7861 --reload" C-m

	tmux new -s chainlit_ui -d
	tmux send-keys -t chainlit_ui "chainlit run --watch interface/chainlit_hf_dev.py" C-m
}

rangdong-stop() {
    tmux kill-session -t fastapi_svc 2>/dev/null
    tmux kill-session -t chainlit_ui 2>/dev/null
    echo "🛑 Dev environment stopped."
}

# User local binaries (uv, uv-installed tools, etc.)
export PATH="/Users/bunnypro/.local/bin:$PATH"

# OpenJDK 17
if [[ -d "/opt/homebrew/opt/openjdk@17" ]]; then
  export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
fi
