function mount
    udisksctl mount -b /dev/$argv
    echo "use 'gm' in ranger"
end
