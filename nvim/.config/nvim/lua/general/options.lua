-- Options --

local opt = vim.opt
local fn = vim.fn

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.cursorline = true
opt.showmatch = true
opt.colorcolumn = '80'
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
opt.number = true
opt.completeopt = { "menu", "menuone", "noselect" }
vim.g.mapleader = ' '

if fn.has('nvim') or fn.has('termguicolors')
then
    opt.termguicolors = true
end
