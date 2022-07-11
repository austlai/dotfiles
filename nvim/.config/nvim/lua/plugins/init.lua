-- Plugins --

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

    -- Themes & Colours
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'ryanoasis/vim-devicons'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'dag/vim-fish'
    Plug 'mboughaba/i3config.vim'
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })
    Plug('rrethy/vim-hexokinase', { ['do'] = vim.fn['make hexokinase'] })

    -- File Searching
    Plug 'junegunn/fzf.vim'
    Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install']})
    Plug 'preservim/nerdtree'

    -- QOL
    Plug 'jiangmiao/auto-pairs'
    Plug 'psliwka/vim-smoothie'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'Vimjas/vim-python-pep8-indent'

    -- LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'onsails/lspkind-nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'williamboman/nvim-lsp-installer'

vim.call('plug#end')

require('plugins.cmp')
require('plugins.fzf')
require('plugins.hexokinase')
require('plugins.indent_blankline')
require('plugins.lightline')
require('plugins.lsp_signature')
require('plugins.nerdtree')
require('plugins.smoothie')
require('plugins.treesitter')
