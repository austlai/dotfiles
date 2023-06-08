-- bufferline --

vim.keymap.set('n', '<Leader>m', ':BufferLinePick<CR>', { silent = true, desc = 'Find buffers' })
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Cycle through buffers' })
vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Cycle through buffers' })

require('bufferline').setup {
    options = {
        mode = "buffers",
        numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bdelete! %d",
        right_mouse_command = "vertical belowright sbuffer %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = "bdelete! %d",
        indicator = { style = "icon", icon="▎" },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 300,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = nil,
        offsets = {{filetype = "NvimTree", text = "", highlight = "Directory", text_align = "left"}},
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin", -- "thick" | "thin"
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'insert_at_end' -- LOTS OF SORT OPTIONS
    }
}

