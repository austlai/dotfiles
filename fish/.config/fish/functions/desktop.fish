function desktop
    xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
           --output HDMI-A-0 --mode 1920x1080 --pos 3840x0 --rotate normal \
           --output DisplayPort-0 --off \
           --output DisplayPort-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
    dpi
end
