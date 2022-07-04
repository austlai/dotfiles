-- Options --

local opt = vim.opt
local fn = vim.fn

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.cursorline = true
opt.showmatch = true
opt.colorcolumn = '80'
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
opt.number = true
opt.completeopt = { "menu", "menuone", "noselect" }

if fn.has('nvim') or fn.has('termguicolors')
then
    opt.termguicolors = true
end
