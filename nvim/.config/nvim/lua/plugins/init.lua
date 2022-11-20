-- Plugins --

return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'

    -- Themes & Colours
    use 'sainnhe/sonokai'
    use 'JoosepAlviste/palenightfall.nvim'
    use 'olimorris/onedarkpro.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'folke/tokyonight.nvim'
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
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'kyazdani42/nvim-tree.lua'

    ---- QOL
    use 'jiangmiao/auto-pairs'
    use 'psliwka/vim-smoothie'
    use 'christoomey/vim-tmux-navigator'
    use 'folke/todo-comments.nvim'
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
    use 'neoclide/vim-jsx-improve'
    use 'wakatime/vim-wakatime'

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

