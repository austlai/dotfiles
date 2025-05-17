#!/usr/bin/env sh

width_height=$(xdpyinfo | awk '/dimensions/ {print $2}')
shotgun - | convert - -scale 10% -blur 0x2.5 -resize "$width_height" RGB:- | i3lock --nofork --raw "$width_height":rgb --image /dev/stdin
