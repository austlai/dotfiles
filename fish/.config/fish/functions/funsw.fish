function funsw
    fusermount -u ~/cse > /dev/null
    sshfs -o idmap=user -C z5358560@login0.cse.unsw.edu.au: ~/cse
end
