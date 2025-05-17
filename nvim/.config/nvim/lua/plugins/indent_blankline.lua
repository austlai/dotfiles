-- Indent Lines --

return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    init = function()
        require("ibl").setup({
            indent = {
                smart_indent_cap = true,
            },
            scope = {
                enabled = true
            }
        })


        local hooks = require("ibl.hooks")
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_space_indent_level
        )

    end
}
