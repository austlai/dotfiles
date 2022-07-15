-- Plugins --

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

    -- Themes & Colours
    Plug 'sainnhe/sonokai'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/bufferline.nvim'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })
    Plug('rrethy/vim-hexokinase', { ['do'] = vim.fn['make hexokinase'] })
    Plug 'mboughaba/i3config.vim'
    Plug 'dag/vim-fish'

    -- File Searching
    Plug 'junegunn/fzf.vim'
    Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install']})
    Plug 'kyazdani42/nvim-tree.lua'

    -- QOL
    Plug 'jiangmiao/auto-pairs'
    Plug 'psliwka/vim-smoothie'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'Vimjas/vim-python-pep8-indent'

    -- LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'onsails/lspkind-nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'L3MON4D3/LuaSnip'

vim.call('plug#end')

require('plugins.cmp')
require('plugins.fzf')
require('plugins.hexokinase')
require('plugins.indent_blankline')
require('plugins.lualine')
require('plugins.bufferline')
require('plugins.lsp_signature')
require('plugins.nerdtree')
require('plugins.nvimtree')
require('plugins.smoothie')
require('plugins.treesitter')
require('plugins.dap')
require('plugins.dapui')
