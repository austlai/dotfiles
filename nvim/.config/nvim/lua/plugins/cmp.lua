-- nvim-cmp --

return {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function(_, opts)
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require("cmp")
    local lspkind = require('lspkind')

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
                vim.schedule(function()
                    vim.snippet.jump(1)
                end)
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
                vim.schedule(function()
                    vim.snippet.jump(-1)
                end)
            else
                fallback()
            end
        end, { "i", "s" }),
    })
        local cmp = require'cmp'

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
                        nvim_lsp = "[LSP]",
                        path = "[Path]",
                        buffer = "[Buffer]",
                        spell = "[Spell]",
                        luasnip = "",
                    },
                },
            },
            experimental = {
                ghost_text = true,
            },
        })
    end
}

