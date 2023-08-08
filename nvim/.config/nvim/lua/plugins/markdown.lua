-- markdown-preview --

return {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
        local set = vim.keymap.set

        set('n', 'M', ':MarkdownPreviewToggle<CR>', { desc = 'Toggle markdown preview' })

        vim.g.mkdp_port = '7070'
        vim.g.mkdp_open_to_the_world = 1
    end
}
