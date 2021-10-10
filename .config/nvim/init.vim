" Plugins
call plug#begin("~/.vim/plugged")
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
    Plug 'jiangmiao/auto-pairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "   Plug 'luochen1990/rainbow'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', {'do':{->fzf#install()}}
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'dag/vim-fish'
    Plug 'mboughaba/i3config.vim'
    Plug 'psliwka/vim-smoothie'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'Vimjas/vim-python-pep8-indent'
    Plug 'ellisonleao/glow.nvim'
    Plug 'mhinz/vim-startify'
call plug#end()

" Basic Settings
set nocompatible                                    " Removes vi compativility
autocmd vimenter * ++nested colorscheme challenger_deep     " Colour scheme
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
set mouse=a                                         " Enable mouse

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
" Resizing windows
nnoremap + :vertical res +5<CR>
nnoremap _ :vertical res -5<CR>
:nnoremap <A->> :res +5<CR>
:nnoremap <A-<> :res -5<CR>
" FZF
nnoremap <silent> <C-f> :Files<CR>
" Glow Markdown Preview
noremap <leader>p :Glow<CR>

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
" Coc
    " Set Tab for complete
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
    " Add Extensions
let g:coc_global_extensions = ['coc-clangd',
                            \  'coc-pyright',
                            \  'coc-html',
                            \  'coc-css']
    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
"""nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>zz
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Lightline
let g:lightline = {
    \ 'colorscheme':'challenger_deep',
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
let g:lightline#bufferline#icon_position = "first"

" NERDTree
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeShowHiddden = 1

" Smoothie
let g:smoothie_speed_exponentiation_factor = 1
set so=999

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

require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}
EOF

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <silent> <C-f> :Files<CR>

" END OF PLUGIN SETTINGS

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

