# dotfiles
My personal dotfiles

## Installation

Install the following dependencies:
- iputils
- git
- which
- neovim
- tmux
- curl
- stow
- zsh
- ripgrep
- fzf
- make
- unzip
- gcc
- g++
- npm

Clone this repository:
```
git clone https://github.com/dLeung09/dotfiles.git ~/.config
```

Clone the tpm plugin:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Use `stow` to symlink config files:
```
cd ~/.config; stow .
```

Make the appropriate TMUX directory structure and config files:
```
mkdir -p ~/.tmux; cp ~/.config/tmux/reset ~/.tmux/reset; echo "source ~/.config/tmux/tmux.conf" > ~/.tmux.conf
```

Copy ZSH config to .zshrc file:
```
cp ~/.config/zshrc/zshrc.conf ~/.zshrc
```

Install Oh-My-ZSH:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/master/tools/install.sh)"

Run TMUX to install plugins.

If using the `kanagawa` theme, the theme file needs to be made executable:
```
chmod +x ~/.tmux/plugins/tmux-kanagawa/kanagawa.tmux
```

Then reload TMUX config.
