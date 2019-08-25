export PATH=/usr/local/bin:$PATH

export ZSH="/Users/alejandro.baeza/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs time)
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❯ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
POWERLEVEL9K_USER_ICON="\uF415" 
POWERLEVEL9K_ROOT_ICON="\uF09C"
POWERLEVEL9K_SUDO_ICON=$'\uF09C'
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_EXPERIMENTAL_TIME_REALTIME=false

POWERLEVEL9K_VCS_GIT_ICON=$'\uF113 '
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"

ZSH_DISABLE_COMPFIX=true

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
	kubetail
	zsh-syntax-highlighting
	zsh-autosuggestions
	)

# Source
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

# Aliases
# Establishing custom commands below

# alias bash_profile="sublime ~/.bash_profile"
alias sublime="open -a /Applications/Sublime\ Text.app"
alias suroot='sudo -E -s'
alias zshconfig="sublime ~/.zshrc" 
alias zprofile="sublime ~/.zprofile"
alias add_github_key="ssh-add -K ~/.ssh/alexbaeza-GitHub"
alias ip="curl https://checkip.amazonaws.com"

# Switch Java versions
alias setJdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
alias setJdk11='export JAVA_HOME=$(/usr/libexec/java_home -v 1.11)'

# Key bindings
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# Project Specific aliases

alias kubectlDev="kubectl config use-context mmodev-aks-dex01; kubectl get pods -n sds"
alias kubectlTest="kubectl config use-context mmotest-aks-dex01; kubectl get pods -n sds"