-- Indent Lines --

return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require("indent_blankline").setup {
            buftype_exclude = {"terminal"},
            use_treesitter = true,
            show_first_indent_level = true,
            show_current_context = true,
            show_current_context_start = true,
        }
    end
}
