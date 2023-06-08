-- Plugins --

return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'

    -- Themes & Colours
    use 'sainnhe/sonokai'
    use 'olimorris/onedarkpro.nvim'
    use 'rakr/vim-one'
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    use 'p00f/nvim-ts-rainbow'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use {
        'rrethy/vim-hexokinase',
        run = 'make hexokinase'
    }

    ---- File Searching
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make' }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'kyazdani42/nvim-tree.lua'

    ---- QOL
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }
    use 'psliwka/vim-smoothie'
    use 'folke/todo-comments.nvim'
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
    use 'wakatime/vim-wakatime'
    use 'christoomey/vim-tmux-navigator'

    ---- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
        },
    }
    use 'onsails/lspkind-nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'L3MON4D3/LuaSnip'

end)

