-- nvim-cmp --

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ["<C-j>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<C-k>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "path", keyword_length = 5 },
        { name = "spell", keyword_length = 3 },
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                nvim_lsp = "ﲳ",
                path = "ﱮ",
                buffer = "﬘",
                spell = "暈",
                luasnip = "",
            },
        },
    },
    experimental = {
        ghost_text = true,
    },
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
    capabilities = capabilities,
}
