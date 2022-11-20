source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh &
#xset r rate 150 30
xset s off -dpms &
numlockx &

#exec i3
exec awesome
