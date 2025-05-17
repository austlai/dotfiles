-- nvim-lsp

require("mason").setup {}
require("mason-lspconfig").setup {
    automatic_installation = {}
}

local nvim_lsp = require('lspconfig')

local border = {
    {"┌", "FloatBorder"},
    {"─", "FloatBorder"},
    {"┐", "FloatBorder"},
    {"│", "FloatBorder"},
    {"┘", "FloatBorder"},
    {"─", "FloatBorder"},
    {"└", "FloatBorder"},
    {"│", "FloatBorder"},
}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap('n', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap('n', '<Leader>a', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})
    vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Language Servers
local lsp_flags = { debounce_text_changes = 150 }
local servers = { 'pyright', 'clangd', 'bashls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }
end

-- Set hover color for definitions and suggestions
local hoverColour = vim.api.nvim_create_augroup("hoverColour", {clear = true})
--vim.api.nvim_create_autocmd("ColorScheme", {
--    command = "hi Pmenu ctermbg=62 guibg=#353157",
--    group = hoverColour,
--    desc = "Sets hover color for definitions and suggestions",
--})
--vim.api.nvim_create_autocmd("ColorScheme", {
--    command = "hi NormalFloat guibg=#353157",
--    group = hoverColour,
--    desc = "Sets hover color for definitions and suggestions",
--})
vim.api.nvim_create_autocmd("ColorScheme", {
    command = "hi FloatBorder guifg=#cbe3e7",
    group = hoverColour,
    desc = "Sets hover color for definitions and suggestions",
})

-- Highlight line numbers for errors
vim.api.nvim_set_hl(0, 'LspDiagnosticsLineNrError', { bg = "#51202A", fg="#FF0000", bold = true })
vim.api.nvim_set_hl(0, 'LspDiagnosticsLineNrWarning', { bg = "#51412A", fg="#FFA500", bold = true })
vim.api.nvim_set_hl(0, 'LspDiagnosticsLineNrInformation', { bg = "#1E535D", fg="#00FFFF", bold = true })
vim.api.nvim_set_hl(0, 'LspDiagnosticsLineNrHint', { bg = "#1E205D", fg="#0000FF", bold = true })

local signs = {
    { name = "DiagnosticSignError", texthl = "LspDiagnosticsSignError", numhl = "LspDiagnosticLineNrError" },
    { name = "DiagnosticSignWarm", texthl = "LspDiagnosticsSignWarning", numhl = "LspDiagnosticLineNrWarning" },
    { name = "DiagnosticSignInfo", texthl = "LspDiagnosticsSignInformation", numhl = "LspDiagnosticLineNrInformation" },
    { name = "DiagnosticSignHint", texthl = "LspDiagnosticsSignHint", numhl = "LspDiagnosticLineNrHint" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = "", texthl = sign.texthl, numhl = sign.numhl })
end
