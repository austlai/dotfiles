-- telescope --
local actions = require "telescope.actions"
local action_utils = require "telescope.actions.utils"
local action_state = require "telescope.actions.state"

local function single_or_multi_select(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local has_multi_selection = (next(current_picker:get_multi_selection()) ~= nil)

    if(has_multi_selection) then
        -- apply function to each selection
        action_utils.map_selections(prompt_bufnr, function (selection)
            local filename = selection[1]
            vim.cmd(':edit! ' .. filename)
        end)

    else
        -- if does not have multi selection, open single file
        actions.file_edit(prompt_bufnr)
    end
end

local actions = require "telescope.actions"
local action_utils = require "telescope.actions.utils"
local action_state = require "telescope.actions.state"

local function single_or_multi_select(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local has_multi_selection = (next(current_picker:get_multi_selection()) ~= nil)

    if(has_multi_selection) then
        -- apply function to each selection
        action_utils.map_selections(prompt_bufnr, function (selection)
            local filename = selection[1]
            vim.cmd(':edit! ' .. filename)
        end)

    else
        -- if does not have multi selection, open single file
        actions.file_edit(prompt_bufnr)
    end
end

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
                ['<cr>'] = single_or_multi_select,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    },
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<C-m>', builtin.buffers, {})
