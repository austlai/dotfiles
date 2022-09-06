-- Commands --

local api = vim.api

local numberToggleGroup = api.nvim_create_augroup("numberToggle", {clear = true})
api.nvim_create_autocmd(
    {"BufEnter", "FocusGained", "InsertLeave", "WinEnter"},
    {
        command = 'if &nu && mode() != "i" | set rnu | endif',
        group = numberToggleGroup,
        desc = "Sets number line to relative",
    }
)
api.nvim_create_autocmd(
    {"BufLeave", "FocusLost", "InsertEnter", "WinLeave"},
    {
        command = "if &nu | set nornu | endif",
        group = numberToggleGroup,
        desc = "Sets number line to nonrelative",
    }
)

-- Remove trailing whitespace
function trimWhitespace()
    local current_view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(current_view)
end

vim.cmd([[
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
]])

vim.api.nvim_create_autocmd("BufWritePre", {
    command = [[lua trimWhitespace()]],
    desc = "Remove trailing whitespace on write",
})

function ftBash()
    if vim.fn.expand('%:e') == ''
    then
        vim.opt.filetype = "sh"
    end
end

function ftPy()
    if vim.fn.expand('%:e') == ''
    then
        vim.opt.filetype = "python"
    end
end

--vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--    command = [[lua ftBash()]],
--    desc = "Set bash ft for files with no extension",
--})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    command = [[lua ftPy()]],
    desc = "Set py ft for files with no extension",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md",
    command = 'silent! !/home/austin/bin/buildmd "%:p"',
    desc = "Auto build markdown files on save",
})
