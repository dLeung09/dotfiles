# dotfiles
My personal dotfiles

## Installation

### Dependencies

```bash
sudo apt-get update
sudo apt-get install -y ripgrep make unzip gcc g++ npm zsh golang
```

### Starship

```bash
curl -sS https://starship.rs/install.sh | sh
```

### Change default shell as `zsh`

```bash
which zsh
chsh -s $(which zsh)
```

### Temporarily update PATH

* Temporarily add `~/.local/bin/` to `PATH`, for verifying installation
    - It will be added permanently by `.zshrc`

```bash
export PATH=$PATH:~/.local/bin
```

### Neovim

```bash
curl -LO https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

export PATH="$PATH:/opt/nvim-linux64/bin"
```

### `eza`

```bash
sudo apt update
sudo apt install -y gpg

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

### `fd`

```bash
sudo apt-get install -y fd-find

mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd
```
### `zoxide`

```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

### Retrieve dotfiles configuration

```bash
git clone https://github.com/dLeung09/dotfiles.git ~/.config
```

### `bat`

```bash
sudo apt install -y bat

mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Configure 'catppuccin' theme
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build
echo '--theme="Catppuccin Mocha"' >> $(bat --config-file)
```

### Install the `tpm` package manager for `tmux`

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Configure `tmux` to use config file

```bash
echo "source ~/.config/tmux/tmux.conf" > ~/.tmux.conf
```

### Configure `zsh` to use config file

```bash
echo "source ~/.config/zshrc/zshrc.conf" > ~/.zshrc
```

### Reboot server

```bash
sudo reboot
```
