-- Treesitter --

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = false,
    },
    indent = {
        enable = true,
    },
}

