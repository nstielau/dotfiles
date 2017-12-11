# Set path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"
if [ $(( ( RANDOM % 2 )  + 1 )) -eq "1" ]; then
  ZSH_THEME="agnoster" # I liked this one, orange and blue, goes nice with Solarized dark.
else
  ZSH_THEME="nstielau"
fi

# Linux additions
if [ "$(uname)" = "Linux" ]; then
  source ~/.zshrc.linux
fi


# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
EDITOR=nano

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias nosleep="gnome-seesion-inhibit --inhibit-only"

# short alias that uses chosen namespace
k () {
    kubectl --namespace=${NS:-default} $@ 2>&1 |  grep -v 'duplicate proto' 
}

# short alias for picking a Kube config
c () {
  export KUBECONFIG=$(find ~/.kube -type f -name '*'"$1"'*' -exec grep -q "clusters:" {} \; -print | fzf --select-1)
}

# helper for setting a namespace
ns () {
    namespaces=$(timeout 10s kubectl get ns -o=custom-columns=:.metadata.name)
    if [ "$?" -eq "124" ]; then
        printf "Could not connect to k8s cluster"
    fi
    export NS=`echo $namespaces | fzf --select-1`
    echo "Set namespace to $NS"
}

kgl () {
    pod=`k get pods | fzf | awk '{print $1}'`
    echo "k logs $pod -c CON"
}

source ~/.fzf_completion.sh

# FZF Colors
export FZF_DEFAULT_OPTS='
  --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
  --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
  --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07
'
# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
