# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# perl
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
if [ -f "/Users/bunnypro/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/Users/bunnypro/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="/Users/bunnypro/miniconda3/bin:$PATH"
fi
# <<< conda initialize <<<
eval "$(direnv hook zsh)"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/bunnypro/.docker/completions $fpath)
# End of Docker CLI completions

# Added by Antigravity
export PATH="/Users/bunnypro/.antigravity/antigravity/bin:$PATH"

alias k=kubectl

export MLOPS="$HOME/Learn/mlops/course-files"

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

export PATH="/Users/bunnypro/.nvm/versions/node/v20.20.0/bin:$PATH"

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
	tmux send-keys -t fastapi_svc "conda activate daai_env" C-m
	tmux send-keys -t fastapi_svc "uvicorn src.api.api:app --port 7861 --reload" C-m

	tmux new -s chainlit_ui -d
	tmux send-keys -t chainlit_ui "conda activate daai_env" C-m
	tmux send-keys -t chainlit_ui "chainlit run --watch interface/chainlit_hf_dev.py" C-m
}

rangdong-stop() {
    tmux kill-session -t fastapi_svc 2>/dev/null
    tmux kill-session -t chainlit_ui 2>/dev/null
    echo "🛑 Dev environment stopped."
}

# FIGMA_PERSONAL_ACCESS_TOKEN=your_figma_token_here

# OpenClaw Completion
# source "/Users/bunnypro/.openclaw/completions/openclaw.zsh"


export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_API_KEY="ollama"
export ANTHROPIC_MODEL="gemma4:12b-optimized" # Built from ~/gemma4-optimized.Modelfile

# Ollama Optimization Environment Variables
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_KEEP_ALIVE=30m
export OLLAMA_KV_CACHE_TYPE="q8_0" # Options: q8_0 (Recommended, saves 50% VRAM), q4_0 (saves 75% VRAM), f16 (default)


export PATH="/Users/bunnypro/.antigravity-ide/antigravity-ide/bin:$PATH"


# Added by Antigravity CLI installer
# Prepend ~/.local/bin and uv Python 3.12 only if conda is not active to avoid hijacking conda environments in subshells
if [[ -z "${CONDA_PREFIX:-}" ]]; then
    export PATH="/Users/bunnypro/.local/bin:$PATH"
    export PATH="/Users/bunnypro/.local/share/uv/python/cpython-3.12-macos-aarch64-none/bin:$PATH"
else
    # Conda is active, so append ~/.local/bin if not already in PATH to preserve conda's python
    if [[ ":$PATH:" != *":/Users/bunnypro/.local/bin:"* ]]; then
        export PATH="$PATH:/Users/bunnypro/.local/bin"
    fi
fi





