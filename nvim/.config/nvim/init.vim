" Plugins
call plug#begin("~/.vim/plugged")
    " Themes & Colours
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'ryanoasis/vim-devicons'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'dag/vim-fish'
    Plug 'mboughaba/i3config.vim'
    Plug 'mhinz/vim-startify'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

    " File Searching
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', {'do':{->fzf#install()}}
    Plug 'preservim/nerdtree'

    " QOL
    Plug 'jiangmiao/auto-pairs'
    Plug 'psliwka/vim-smoothie'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'Vimjas/vim-python-pep8-indent'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'onsails/lspkind-nvim'
    Plug 'ray-x/lsp_signature.nvim'

    " Other
    Plug 'ellisonleao/glow.nvim'

call plug#end()

" Basic Settings
set nocompatible                                    " Removes vi compativility
set tabstop=4                                       " Number of visual spaces per tab
set softtabstop=4                                   " Number of spaces in tab
set expandtab                                       " Turns tabs into spaces
set shiftwidth=4                                    " Indent = singletab
set autoindent                                      " Autoindenting
set smartindent                                     " Smart indenting
set cursorline                                      " Highlights current line
filetype plugin indent on                           " Enables filetype detection
set showmatch                                       " Highlights matching parenthesis
set incsearch                                       " Search as characters are entered
set hlsearch                                        " Highlight search matches
set cc=80                                           " 80 char column
syntax on                                           " Syntax highlighting
set wildmenu                                        " Autocomplete for commands
set clipboard+=unnamedplus                          " Sets up system clipboard usage
set mouse=a


" Colourschemes
let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

" Custom Key Mappings
" jk => esc
inoremap jk <esc>
" Ctrl + hjkl => window control
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l
" Removes macro recording
map q <Nop>
" Remove Ex mode
map Q <Nop>
" Resizing windows
nnoremap + :vertical res +5<CR>
nnoremap _ :vertical res -5<CR>
:nnoremap <A->> :res +5<CR>
:nnoremap <A-<> :res -5<CR>
" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Custom Number Lines
set number                                          " Shows numberlines

augroup numbertoggle                                " Switches between hybrid and absolute number lines based on active
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Colors
if has('nvim') || has('termguicolors')
    set termguicolors
endif

" Plugin Settings

" nvim-lsp

    " Set hover color for definitions and suggestions
hi Pmenu ctermbg=62 guibg=#353157
hi NormalFloat guibg=#353157
hi FloatBorder guifg=#cbe3e7 guibg=#353157

lua << EOF

require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}

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
    buf_set_keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
    vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
end

-- Add other language servers when required
local servers = { 'pyright', 'clangd' }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            }
    }
end

EOF

    " Highlight Line numbers for erros
highlight LspDiagnosticsLineNrError guibg=#51202A guifg=#FF0000 gui=bold
highlight LspDiagnosticsLineNrWarning guibg=#51412A guifg=#FFA500 gui=bold
highlight LspDiagnosticsLineNrInformation guibg=#1E535D guifg=#00FFFF gui=bold
highlight LspDiagnosticsLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

sign define DiagnosticSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsLineNrError
sign define DiagnosticSignWarn text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsLineNrWarning
sign define DiagnosticSignInfo text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsLineNrInformation
sign define DiagnosticSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsLineNrHint

" nvim-cmp
set completeopt=menu,menuone,noselect

lua << EOF

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
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
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "path", keyword_length = 5 },
        { name = "buffer", keyword_length = 3 },
        { name = "spell", keyword_length = 3 },
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    documentation = {
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                nvim_lsp = "ﲳ",
                path = "ﱮ",
                buffer = "﬘",
                spell = "暈",
            },
        },
    },
    experimental = {
        ghost_text = true,
    },
})
EOF

" lsp_signature
lua << EOF

require "lsp_signature".setup({
    floating_window_above_cur_line = true,
    hint_enable = false,
    doc_lines = 0,
})

EOF

" Lightline
let g:lightline = {
    \ 'colorscheme':'sonokai',
    \ 'tabline': {
    \    'left': [['buffers']]
    \ },
    \ 'component_expand': {
    \    'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \    'buffers': 'tabsel'
    \ }
    \ }
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#min_buffer_count = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferlineicon_position = "first"

" NERDTree
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeShowHiddden = 1

" Smoothie
let g:smoothie_speed_exponentiation_factor = 1

" Startify
let g:startify_custom_header = [
\'    _   _      __     __                   __  __',
\'   | \ |"|     \ \   /"/u       ___      U|^ \/ ^|u',
\'  <|  \| |>     \ \ / //       |_"_|     \| |\/| |/',
\'  U| |\  |u     /\ V /_,-.      | |       | |  | |',
\'   |_| \_|     U  \_/-(_/     U/| |\u     |_|  |_|',
\'   ||   \\,-.    //        .-,_|___|_,-.   ||  ||',
\'   (_")  (_/    (__)        \_)-` `-(_/   (./  \.)',
\]
highlight StartifySection ctermfg=42

" Indent Lines
lua <<EOF
require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}
EOF

" Rainbow Brackets
"""let g:rainbow_active = 1

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <silent> <C-f> :Files<CR>

" Treesitter, Rainbow
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
    },
    indent = {
        enable = false,
    },
}
EOF

" Hexokinase (Colour codes)
let g:Hexokinase_highlighters = [ 'virtual' ]

" END PLUGIN SETTINGS

" Function + Command to remove trailing whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! Trail call TrimWhitespace()

" Show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
