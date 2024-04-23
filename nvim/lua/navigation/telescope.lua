local M = {}

function M.get_telescope_theme(opts)
    opts = opts or {}

    local theme_opts = {
        theme = 'custom',

        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.9,
            height = 0.95,
            preview_cutoff = 120,
        },

        border = true,
        borderchars = {
            prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
            results = { ' ' },
            preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        },
    }
    if
        theme_opts.layout_config
        and theme_opts.layout_config.horizontal.prompt_position == 'bottom'
    then
        theme_opts.borderchars = {
            prompt = { '─', '│', '─', '│', '│', '│', '┴', '└' },
            results = { '─', '│', ' ', '│', '┌', '┬', '│', '│' },
            preview = { '─', '│', '─', ' ', '─', '┐', '┘', '─' },
        }
        theme_opts.sorting_strategy = 'descending'
    else
        theme_opts.borderchars = {
            prompt = { '─', '│', '─', '│', '┌', '┬', '│', '│' },
            results = { ' ', '│', '─', '│', '│', '│', '┴', '└' },
            preview = { '─', '│', '─', ' ', '─', '┐', '┘', '─' },
        }
    end

    return vim.tbl_deep_extend('force', theme_opts, opts)
end

function M.setup()
    local actions = require('telescope.actions')
    local trouble = require('trouble.sources.telescope')

    require('telescope').setup({
        defaults = {
            dynamic_preview_title = true,
            sorting_strategy = 'ascending',
            results_title = false,
            selection_caret = ' > ',
            entry_prefix = '   ',
            mappings = {
                i = {
                    ['<tab>'] = actions.move_selection_next,
                    ['<S-tab>'] = actions.move_selection_previous,
                    ['<esc>'] = actions.close,
                    ['<c-t>'] = trouble.open,
                },
                n = { ['<c-t>'] = trouble.open_with_trouble },
            },
        },
        extensions = {
            undo = {
                side_by_side = true,
                sorting_strategy = 'descending',
                layout_strategy = "horizontal",
                layout_config = {
                    preview_height = 0.8,
                },
            },
        },
    })
end

return M
