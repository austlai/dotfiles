set -Ux MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -Ux LS_COLORS 'di=01;36'
set -Ux TERMINAL 'alacritty'
set -gx EDITOR 'nvim'
###########
# Aliases #
###########

# Quick Edits
alias envim="cd ~/.config/nvim && nvim"
alias editfish="nvim ~/.config/fish/config.fish"
alias editi3="nvim ~/.config/i3/config"

# Uni
alias project="cd ~/Documents/uni/comp1531/project-backend"
