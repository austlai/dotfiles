-- lightline --

vim.g['lightline'] = {
    colorscheme = 'sonokai',
    tabline = {
        left = {{'buffers'}}
    },
    component_expand = {
        buffers = 'lightline#bufferline#buffers'
    },
    component_type = {
        buffers = 'tabsel'
    }
}
vim.g['lightline#bufferline#show_number'] = 1
vim.g['lightline#bufferline#min_buffer_count'] = 1
vim.g['lightline#bufferline#enable_devicons'] = 1
vim.g['lightline#bufferlineicon_position'] = "first"
