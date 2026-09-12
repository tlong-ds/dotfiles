# Docker CLI tools
[[ -d "/Users/bunnypro/.docker/bin" ]] && export PATH="$PATH:/Users/bunnypro/.docker/bin"

# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# User local binaries (uv, pipx, local CLI tools)
export PATH="/Users/bunnypro/.local/bin:$PATH"
