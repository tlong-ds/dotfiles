#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "==========================================="
echo "   Starting Dotfiles Bootstrapping...      "
echo "==========================================="

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# ----------------------------------------------------
# 1. Install Homebrew & Packages
# ----------------------------------------------------
if [ -n "$SKIP_BREW" ]; then
    echo "Skipping Homebrew and packages installation."
else
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Configure Homebrew path for the current session
        if [ -d "/opt/homebrew/bin" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -d "/usr/local/bin" ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo "Homebrew is already installed."
    fi

    if [ -f "$DOTFILES_DIR/Brewfile" ]; then
        echo "Installing/updating packages from Brewfile..."
        brew bundle install --file="$DOTFILES_DIR/Brewfile"
    else
        echo "No Brewfile found in $DOTFILES_DIR. Skipping..."
    fi
fi

# ----------------------------------------------------
# 2. Install NVM & Node.js & Global NPM Packages
# ----------------------------------------------------
if [ -n "$SKIP_NODE" ]; then
    echo "Skipping NVM, Node.js, and global NPM packages installation."
else
    export NVM_DIR="$HOME/.nvm"

    if [ ! -d "$NVM_DIR" ]; then
        echo "NVM not found. Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    fi

    # Load NVM
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    if command -v nvm >/dev/null 2>&1; then
        echo "NVM loaded successfully."
        # We will install Node v20.20.0 as specified in your .zshrc
        echo "Installing/using Node.js v20.20.0..."
        nvm install v20.20.0
        nvm use v20.20.0
        nvm alias default v20.20.0
    else
        echo "Warning: NVM could not be loaded. Skipping Node setup."
    fi

    # Install global npm packages from npm-global.txt
    if command -v npm >/dev/null 2>&1; then
        if [ -f "$DOTFILES_DIR/npm-global.txt" ]; then
            echo "Installing global NPM packages..."
            while IFS= read -r pkg || [ -n "$pkg" ]; do
                # Skip empty lines or comments
                [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
                echo "Installing global npm package: $pkg"
                npm install -g "$pkg" || echo "Failed to install $pkg, skipping..."
            done < "$DOTFILES_DIR/npm-global.txt"
        fi
    else
        echo "Warning: NPM is not available. Skipping global packages."
    fi
fi


# ----------------------------------------------------
# 3. Create Backup & Symbolic Links
# ----------------------------------------------------
echo "Creating backup folder at: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Define files to link: "source_in_dotfiles" "destination_in_home"
FILES_TO_LINK=(
    ".zshrc" ".zshrc"
    ".zprofile" ".zprofile"
    ".zshenv" ".zshenv"
    ".p10k.zsh" ".p10k.zsh"
    ".gitconfig" ".gitconfig"
    ".gitignore" ".gitignore"
    ".skhdrc" ".skhdrc"
    ".condarc" ".condarc"
    ".xonshrc" ".xonshrc"
    ".claude.json" ".claude.json"
    ".antigravity/argv.json" ".antigravity/argv.json"
    ".codex/config.toml" ".codex/config.toml"
    ".config/ghostty" ".config/ghostty"
    ".config/nvim" ".config/nvim"
    ".config/zed" ".config/zed"
    ".config/fish" ".config/fish"
    ".config/btop" ".config/btop"
    "bin/audio-manager.swift" "bin/audio-manager.swift"
    "bin/microphone_protector.applescript" "bin/microphone_protector.applescript"
    "bin/setup-microphone-protector.sh" "bin/setup-microphone-protector.sh"
    "Library/LaunchAgents/com.bunnypro.microphone-protector.plist" "Library/LaunchAgents/com.bunnypro.microphone-protector.plist"
)

for ((i=0; i<${#FILES_TO_LINK[@]}; i+=2)); do
    src="${FILES_TO_LINK[i]}"
    dst="${FILES_TO_LINK[i+1]}"
    
    src_path="$DOTFILES_DIR/$src"
    dst_path="$HOME/$dst"
    
    # Only link if the source file actually exists in our dotfiles repo
    if [ -e "$src_path" ] || [ -L "$src_path" ]; then
        # Check if target already exists in HOME
        if [ -e "$dst_path" ] || [ -L "$dst_path" ]; then
            if [ -L "$dst_path" ]; then
                echo "Removing existing symlink: ~/$dst"
                rm "$dst_path"
            else
                echo "Backing up: ~/$dst -> $BACKUP_DIR/$dst"
                # Ensure nested folder structure exists in the backup directory
                mkdir -p "$(dirname "$BACKUP_DIR/$dst")"
                mv "$dst_path" "$BACKUP_DIR/$dst"
            fi
        fi
        
        # Ensure target's parent directory exists
        mkdir -p "$(dirname "$dst_path")"
        
        # Create the symbolic link
        echo "Linking: ~/$dst -> $src_path"
        ln -sf "$src_path" "$dst_path"
    else
        echo "Source file $src_path does not exist. Skipping link."
    fi
done

# Clean up empty backup directory if nothing was backed up
if [ -d "$BACKUP_DIR" ] && [ -z "$(ls -A "$BACKUP_DIR")" ]; then
    rmdir "$BACKUP_DIR"
    echo "No existing files to back up. Backup folder cleaned up."
fi

# ----------------------------------------------------
# 4. Initialize Microphone Protector
# ----------------------------------------------------
if [ -f "$HOME/bin/setup-microphone-protector.sh" ]; then
    echo "Setting up Microphone Protector..."
    chmod +x "$HOME/bin/setup-microphone-protector.sh"
    "$HOME/bin/setup-microphone-protector.sh"
fi

echo "==========================================="
echo "   Dotfiles Bootstrapping Completed!      "
echo "==========================================="
