-- fzf --

vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
vim.keymap.set('n', '<C-f>', ':Files<CR>', { silent = true, desc = 'Find files' })
vim.keymap.set('n', '<C-g>', ':Ag<CR>', { silent = true, desc = 'Find in files' })
vim.keymap.set('n', '<Leader>m', ':Buffers<CR>', { silent = true, desc = 'Find buffers' })
