-- markdown-preview --


local set = vim.keymap.set

set('n', 'M', ':MarkdownPreviewToggle<CR>', { desc = 'Toggle markdown preview' })

vim.g.mkdp_port = '7070'
vim.g.mkdp_open_to_the_world = 1

-- headlines.nvim --

-- require('headlines').setup()
