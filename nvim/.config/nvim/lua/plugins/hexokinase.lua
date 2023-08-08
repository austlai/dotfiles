-- Hexokinase --

return {
    'rrethy/vim-hexokinase',
    build = 'make hexokinase',
    config = function()
        vim.g.Hexokinase_highlighters = {'virtual'}
    end
}
