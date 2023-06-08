-- Keymaps --

local set = vim.keymap.set

set('i', 'jk', '<esc>', { desc = 'Set jk as escape' })
set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { desc = 'Fix spelling mistakes in line' })
set('n', '<C-h>', '<C-w>h', { desc = 'Move to different window' })
set('n', '<C-j>', '<C-w>j', { desc = 'Move to different window' })
set('n', '<C-k>', '<C-w>k', { desc = 'Move to different window' })
set('n', '<Leader>+', ':vertical res +5<CR>', { desc = 'Resizing vertical windows' })
set('n', '<Leader>-', ':vertical res -5<CR>', { desc = 'Resizing vertical windows' })
set('n', '<C-l>', '<C-w>l', { desc = 'Move to different window' })
set('n', '<C-l>', '<C-w>l', { desc = 'Move to different window' })
set('n', '<Leader>n', ':bn<CR>', { desc = 'Move to next buffer' })
set('n', '<Leader>b', ':bp<CR>', { desc = 'Move to prev buffer' })
set('n', '<Leader>d', ':bd<CR>', { desc = 'Delete buffer' })
set('v', '<', '<gv', { desc = 'Move indentation of block' })
set('v', '>', '>gv', { desc = 'Move indentation of block' })
set('v', 'J', [[:m '>+1<CR>gv=gv]], { desc = 'Moves selected lines down' })
set('v', 'K', [[:m '<-2<CR>gv=gv]], { desc = 'Moves selected lines up' })
set('', 'q', '<Nop>', { desc = 'Removes macros recording' })
set('', 'Q', '<Nop>', { desc = 'Removes Ex mode' })
