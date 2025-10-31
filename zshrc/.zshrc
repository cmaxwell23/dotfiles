# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git ssh-agent zsh-autosuggestions asdf)
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR=/opt/homebrew/bin/nvim

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Git
alias ga='git add .'
alias gc='git commit'
alias gco='git checkout'
alias gl='git pull'
alias gph='git push origin head'
alias gd='git diff'
alias gb='git branch'
alias gbr='git branch | grep -v "master" | xargs git branch -D'

export GPG_TTY=$(tty)

# Docker
alias docker-prune-cow='rm -fr ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2'
alias docker-rmi='docker rmi $(docker images -q)'
alias docker-rm='docker rm -f $(docker ps -a -q)'

# https://aosolorzano.medium.com/installing-colima-as-a-docker-engine-provider-with-buildx-and-compose-plugins-installed-1ce8b3bae158
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Go
export PATH=$PATH:$(go env GOPATH)/bin

# Local bin
export PATH=$PATH:~/.local/bin

# Local dev
export GITHUB_DEPLOY_KEY=$(exec cat ~/.ssh/id_rsa)
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# set the nvm / node version from the current directory's .nvmrc file (if exists)
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
# add-zsh-hook chpwd load-nvmrc
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
PATH=$(pyenv root)/shims:$PATH

# imagemagick
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/imagemagick@6/lib/pkgconfig"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# bun completions
[ -s "/Users/cmax/.bun/_bun" ] && source "/Users/cmax/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Added by Windsurf
export PATH="/Users/cmax/.codeium/windsurf/bin:$PATH"

# Claude Code
alias claude="/Users/cmax/.claude/local/claude"

# opencode
export PATH=/Users/cmax/.opencode/bin:$PATH

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# atuin
. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
