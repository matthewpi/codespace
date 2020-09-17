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
curl https://raw.githubusercontent.com/matthewpi/codespace/master/.devcontainer/.zshrc --silent --output /home/$USERNAME/.zshrc
chown -R $USER_UID:$USER_GID /home/$USERNAME/.oh-my-zsh /home/codespace/.zshrc

# Install fast-syntax-highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting.git /home/$USERNAME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Install starship
mkdir /home/$USERNAME/.config
curl https://raw.githubusercontent.com/matthewpi/codespace/master/.devcontainer/starship.toml --silent --output /home/$USERNAME/.config/starship.toml

wget -O- -q "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz" | tar xzf - -C "/usr/local/bin"
chown $USER_UID:$USER_GID /usr/local/bin/starship
