# Path
export PATH=$HOME/bin:/usr/local/bin:$HOME/applications:$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/.cargo/bin

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

# alias vault="cd ~/Documents/vacuum_cleaner/00_personal/daily/2024"

alias half="sudo tlp setcharge 50 75 BAT0"
alias full="sudo tlp fullcharge BAT0"
alias boostoff="echo '0' | sudo tee /sys/devices/system/cpu/cpufreq/boost"

alias pi="ssh austin@astrotrain.local"
alias mc="ssh austinlai2112@34.116.93.170"

alias update="sudo apt update && sudo apt upgrade"

alias stardew="cd ~/.steam/debian-installation/steamapps/common/'Stardew Valley'"

game() {
  if [[ $(xinput --list-props "ETPS/2 Elantech Touchpad" | grep "Disable While Typing Enabled (" | tail -c 2) -eq 0 ]]
    then
        xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Disable While Typing Enabled" 1
        echo "Disabled Trackpad While Typing"
    else
        xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Disable While Typing Enabled" 0
        echo "Enabled Trackpad While Typing"
    fi
}

untar() {
    tar -xvf "$1"
}

source /home/austin/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias discup="wget -qO discord.deb https://discord.com/api/download\?platform\=linux\&format\=deb && sudo dpkg -i discord.deb"

day() {
    filename="$(date +"%Y-%m-%d").md"

    cd ~/Documents/vacuum_cleaner/00_personal/daily/2024
    mkdir -p "$(date +"%m")" && touch "$(date +%m)/$filename"

    cd "$(date +"%m")"

    echo "# $(date +"%Y-%m-%d %A")" >> $filename
    echo "#journal\n" >> $filename

    nvim $filename
}

check_day() {
    rg "$(date +"%Y-%m-%d %A")" ~/Documents/vacuum_cleaner/00_personal/daily/2024 -q

    if [[ $? -ne 0 ]]
    then
        echo "┌─────────────────────────────────────────────────────────┐"
        echo "│ Hey Austin, you haven't written anything for today yet! │"
        echo "│ (Run \`day\` for a new file)                              │"
        echo "└─────────────────────────────────────────────────────────┘"
    else
    fi
}

check_day

eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/home/austin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
. "/home/austin/.deno/env"
# bun completions
[ -s "/home/austin/.bun/_bun" ] && source "/home/austin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
