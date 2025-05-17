-- Treesitter --

return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "vim", "lua", "vimdoc", "query", "python", "rust" },
            ignore_install = { "phpdoc" },
            highlight = {
                enable = true,
            },
            rainbow = {
                enable = true,
                disable = { 'jsx' }
            },
            indent = {
                enable = true,
            },
        }
    end
}
