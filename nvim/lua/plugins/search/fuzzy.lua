local telescope_theme = require("utils.telescope_theme")

return {
    --  Fuzzy finders
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' }, { 'folke/trouble.nvim' } },
        config = function()
            require('telescope').setup({
                defaults = telescope_theme.get_telescope_theme({
                    dynamic_preview_title = true,
                    sorting_strategy = 'ascending',
                    results_title = false,
                    selection_caret = ' > ',
                    entry_prefix = '   ',
                    mappings = {
                        i = {
                            ['<tab>'] = require('telescope.actions').move_selection_next,
                            ['<S-tab>'] = require('telescope.actions').move_selection_previous,
                            ['<esc>'] = require('telescope.actions').close,
                            ['<c-t>'] = require('trouble.sources.telescope').open,
                        },
                        n = { ['<c-t>'] = require('trouble.sources.telescope').open_with_trouble },
                    },
                }),
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                }
            })

            require('telescope').load_extension('fzf')
        end,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'junegunn/fzf',                             enabled = false },
    { 'ibhagwan/fzf-lua',                         enabled = false },
}
