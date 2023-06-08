function wakeup --wraps='sudo wol -p 9 8:5E:D3:A2:1D:E3' --description 'alias wakeup sudo wol -p 9 8:5E:D3:A2:1D:E3'
  sudo wol -p 9 8:5E:D3:A2:1D:E3 $argv
        
end
