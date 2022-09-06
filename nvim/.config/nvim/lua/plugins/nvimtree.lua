-- nvimtree --
vim.keymap.set('n', '<Leader>f', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle NERDTree' })
vim.keymap.set('n', '<Leader>s', ':NvimTreeFindFile<CR>', { silent = true, desc = 'Find NERDTree' })

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    view = {
        mappings = {
            list = {
                { key = "o", action = "create" },
                { key = "v", action = "vsplit" },
            },
        },
    },
    renderer = {
        highlight_git = false,
        indent_markers = {
            enable = true
        },
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "✗",
                    deleted = "",
                    ignored = "◌",
                },
            },
        }
    },
})
