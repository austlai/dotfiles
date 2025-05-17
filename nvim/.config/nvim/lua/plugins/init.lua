-- Plugins --

return {
    -- Themes & Colours
    {
        'rebelot/kanagawa.nvim',
        config = function()
            require("kanagawa").load("wave")
        end
    },
    'HiPhish/nvim-ts-rainbow2',
    'kyazdani42/nvim-web-devicons',
    ---- File Searching
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    ---- QOL
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    },
    {
        'folke/todo-comments.nvim',
        event = "VimEnter",
        config = function()
            require('todo-comments').setup()
        end
    },
    'wakatime/vim-wakatime',
    'christoomey/vim-tmux-navigator',

    ---- LSP
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-cmdline',
    'onsails/lspkind-nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'L3MON4D3/LuaSnip',

}

