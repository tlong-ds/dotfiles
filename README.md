# ⚙️ dotfiles

My personal system configurations, tools, and coding agents setup for macOS.

## 📦 What's Included

* **Shell**: `zsh` configured with Oh My Zsh, Powerlevel10k, `.zshrc`, `.zprofile`, `.zshenv`, and `.xonshrc`.
* **Package Management**:
  * `Brewfile`: Lists all installed Homebrew formulae, casks, and taps.
  * `npm-global.txt`: Lists all global NPM packages (including CLI tools and coding agents).
* **Coding Agents & Tools**:
  * Claude (`.claude.json`)
  * Codex (`.codex/config.toml`)
  * Antigravity (`.antigravity/argv.json`)
* **Window Manager**: `Aerospace` (`.aerospace.toml`) and `skhd` (`.skhdrc`).
* **Applications**:
  * Neovim (based on kickstart.nvim)
  * Ghostty
  * Karabiner-Elements
  * Zed Editor
  * fish shell
  * btop

---

## 🚀 Installation & Bootstrapping

Clone this repository to your home directory:

```bash
git clone https://github.com/tlong-ds/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 1. Full Bootstrap (Recommended on a new machine)
This will check/install Homebrew, restore all formulae and casks, setup NVM and Node.js v20.20.0, install global NPM packages, backup existing dotfiles, and link everything:

```bash
./bootstrap.sh
```

### 2. Fast Bootstrap (Skip updates and package installations)
If you only want to backup and symlink your configuration files without running the Homebrew/NVM update processes:

```bash
SKIP_BREW=1 SKIP_NODE=1 ./bootstrap.sh
```

---

## 🔒 Security Note
Sensitive configuration files such as API credentials and tokens (e.g., `~/.ssh/`, `~/.codex/auth.json`, `~/.config/github-copilot/apps.json`) are **excluded** from this repository to ensure privacy and security.
