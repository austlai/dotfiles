export PATH=$HOME/bin:/usr/local/bin:$HOME/applications:$PATH

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

PROMPT='%F{#9bd690}[%f%F{#c790d6}austin%f%F{#9bd690}@%f%F{#81a2be}ironhide%f %F{#f0c674}%~%f%F{white}${vcs_info_msg_0_}%f%F{#9bd690}]$ %f'

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

alias mouse="xinput set-prop 'pointer:Logitech G Pro' 'libinput Accel Profile Enabled' 0, 1 && \
  xinput set-prop 'pointer:Logitech G Pro' 'libinput Accel Speed' -0.42"
alias balance="bspc node -f @parent && bspc node --ratio 0.5 && bspc node -f last"

alias vault="cd ~/Documents/vacuum_cleaner/01_uni"
alias keymap="cd ~/qmk_firmware/keyboards/sofle/keymaps/austlai/"

alias mchost="ssh austin@170.64.174.61"

alias tomato="alacritty msg config window.opacity=0.6; /usr/local/bin/tomato"
alias himym="sudo mount -m /dev/sdb2 /run/media/austin/Hitachi; devour vlc ~/linuxHIMYM.xspf"

alias unsw="ssh z5358560@login0.cse.unsw.edu.au"
alias cgend="cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && mv build/compile_commands.json ."
alias cgenr="cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && mv build/compile_commands.json ."
alias cbuild="cmake --build ."

updates() {
    news=''
    yay -Sy
    if [ $(eval 'yay -Pw | wc -l') -eq 0 ]
    then
        news="No News"
    else
        news="Recent News"
    fi
    echo "$(eval 'yay -Qu | wc -l') updates available ($news)"
}


