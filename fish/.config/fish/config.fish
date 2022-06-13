if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -Ux MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -Ux LS_COLORS 'di=01;36'
set -Ux TERMINAL 'alacritty'
###########
# Aliases #
###########

# Quick Edits
alias envim="nvim ~/.config/nvim/init.vim"
alias editfish="nvim ~/.config/fish/config.fish"
alias editi3="nvim ~/.config/i3/config"

# Uni
alias project="cd ~/Documents/uni/comp1531/project-backend"
