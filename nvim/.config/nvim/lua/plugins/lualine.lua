-- lualine --

local diagnostics = {
  "diagnostics",
  colored = false,
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
        padding = 2,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {diagnostics},
        lualine_x = {'filename'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    extensions = {}
}
