-- fzf --

vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
vim.keymap.set('n', '<C-f>', ':Files<CR>', { silent = true, desc = 'Find file' })
vim.keymap.set('n', '<C-g>', ':Ag<CR>', { silent = true, desc = 'Find in file' })
