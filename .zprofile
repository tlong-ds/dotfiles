# Docker CLI tools
[[ -d "/Users/bunnypro/.docker/bin" ]] && export PATH="$PATH:/Users/bunnypro/.docker/bin"

# Homebrew environment (fast, disable slow auto-updates on every install)
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
eval "$(/opt/homebrew/bin/brew shellenv)"

# User local binaries (uv, pipx, local CLI tools)
export PATH="/Users/bunnypro/.local/bin:$PATH"
