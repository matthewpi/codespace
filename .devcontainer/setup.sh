#!/bin/bash

set -euo pipefail

dnf update -y
dnf install -y epel-release
dnf update -y

dnf install -y \
    curl \
    git \
    htop \
    jq \
    wget \
    zsh

# Install golang
cd /root
wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar xzf go1.15.2.linux-amd64.tar.gz
mv go /usr/local/

# Setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
cp -R /root/.oh-my-zsh /home/$USERNAME
cat >> /home/$USERNAME/.zshrc <<EOL
# Matthew's .zshrc (oh-my-zsh)
export ZSH=$HOME/.oh-my-zsh

# Disable update prompt (forces oh-my-zsh to always update)
DISABLE_UPDATE_PROMPT=true

# Plugins
plugins=(
	zsh-autosuggestions
	fast-syntax-highlighting
)

# zsh-autosuggestions Settings
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# fast-syntax-highlighting Settings

# Initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Environment Variables
EDITOR=nano

# Golang Environment Variables
GOPATH=$HOME/.golang
GOBIN=$GOPATH/bin

# Add "go" to PATH
PATH="$PATH:/usr/local/go/bin"

# Add GOBIN to Path
PATH="$PATH:$GOBIN"

# Exports
export EDITOR
export GOPATH
export GOBIN
export PATH

# Aliases
alias ll="ls -la"
alias please="sudo "
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Runs 'git pull' on all oh-my-zsh custom plugins
zsh_update_plugins() {
    for i in $(fd . "$HOME/.oh-my-zsh/custom/plugins" --threads 1 --exact-depth 1 --type d); do
                # Switch to the plugin's directory.
                cd $i


                # Check if the directory is a git root, not just inside of a git repository.
                # Basically if the plugin's directory has a ".git" folder.
                if [ -d .git ]; then
                        # Print what directory we are in.
                        echo -e "\n\033[32m${PWD##*/}\033[0m"
                        git pull
                else
                        echo -e "\n\033[31m${PWD##*/}\033[0m"
                        echo -e "\033[33mWARNING:\033[0m not a git root"
                fi
        done

        cd $HOME
}

# Bat Settings
BAT_THEME="Nord"
export BAT_THEME

# https://starship.rs
eval "$(/usr/local/bin/starship init zsh)"
EOL
chown -R $USER_UID:$USER_GID /home/$USERNAME/.oh-my-zsh /home/$USERNAME/.zshrc

# Install fast-syntax-highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting.git /home/$USERNAME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Install starship
mkdir /home/$USERNAME/.config
cat >> /home/$USERNAME/.config/starship.toml <<EOL
[hostname]
disabled = true

[username]
disabled = true

# Nerd Fonts
[aws]
symbol = " "

[battery]
full_symbol = ""
charging_symbol = ""
discharging_symbol = ""

[conda]
symbol = " "

[docker]
symbol = " "

[elixir]
symbol = " "

[elm]
symbol = " "

[git_branch]
symbol = " "

[golang]
symbol = " "

[haskell]
symbol = " "

[hg_branch]
symbol = " "

[java]
symbol = " "

[julia]
symbol = " "

[memory_usage]
symbol = " "

[nim]
symbol = " "

[nix_shell]
symbol = " "

[nodejs]
symbol = " "

[package]
symbol = " "

[php]
symbol = " "

[python]
symbol = " "

[ruby]
symbol = " "

[rust]
symbol = " "
EOL

wget -O- -q "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz" | tar xzf - -C "/usr/local/bin"
chown root:root /usr/local/bin/starship
