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
eval "$(starship init zsh)"
