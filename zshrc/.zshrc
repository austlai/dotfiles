export PATH=$HOME/bin:/usr/local/bin:$HOME/applications:$PATH:/usr/local/go/bin

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Git autocomplete faster
__git_files () {
    _wanted files expl 'local files' _files
}

# Custom Terminal colours
LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=1;95:st=37;44:ex=01;32:";
export LS_COLORS

# Path
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Beep
unsetopt beep

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' (%b)'

setopt PROMPT_SUBST

PROMPT='%F{#9bd690}[%f%F{#c790d6}austin%f%F{#9bd690}@%f%F{#81a2be}soundwave%f %F{#f0c674}%~%f%F{white}${vcs_info_msg_0_}%f%F{#9bd690}]$ %f'

export TERMINAL=alacritty
export EDITOR=nvim
export MANPAGER='less -R --use-color -Dd+r -Du+b'
export LS_COLORS='di=01;36'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias
alias mix="pulsemixer"
alias bm="bashmount"
alias tmux="/usr/bin/tmux attach"
alias tmuxn="/usr/bin/tmux new"

alias vault="cd ~/Documents/vacuum_cleaner/01_uni"

alias half="sudo tlp setcharge 50 75 BAT0"
alias full="sudo tlp fullcharge BAT0"

alias pi="ssh austin@astrotrain.local"
alias unsw="ssh z5358560@login0.cse.unsw.edu.au"

alias update="sudo apt update && sudo apt upgrade && flatpak update"

source /home/austin/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
