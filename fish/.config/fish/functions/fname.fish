function fname --wraps=\\ls\ \|\ nvim\ - --description alias\ fname\ \\ls\ \|\ nvim\ -
  \ls | nvim - $argv
        
end
