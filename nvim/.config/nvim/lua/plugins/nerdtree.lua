-- NERDTree --

vim.keymap.set('n', '<Leader>f', ':NERDTreeToggle<CR>', { desc = 'Toggle NERDTree' })
vim.keymap.set('n', '<Leader>s', ':NERDTreeFind<CR>', { silent = true, desc = 'Find NERDTree' })

vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowHiddden = 1
