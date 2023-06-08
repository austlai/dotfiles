require('general.options')
require('general.mappings')
require('general.commands')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins')

--require('plugins.cmp')
--require('plugins.telescope')
--require('plugins.hexokinase')
--require('plugins.indent_blankline')
--require('plugins.lualine')
--require('plugins.bufferline')
--require('plugins.lsp_signature')
--require('plugins.nerdtree')
--require('plugins.nvimtree')
--require('plugins.smoothie')
--require('plugins.treesitter')
--require('plugins.markdown')

-- bufferline
vim.keymap.set('n', '<Leader>m', ':BufferLinePick<CR>', { silent = true, desc = 'Find buffers' })
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Cycle through buffers' })
vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Cycle through buffers' })


require('general.colours')

require('lsp')
