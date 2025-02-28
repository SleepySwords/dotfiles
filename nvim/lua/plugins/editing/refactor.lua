return {
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        lazy = false,
        config = function()
            require('refactoring').setup({})
        end,
    },
    {
        'Sleepyswords/change-function.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        config = function()
            local change_function = require('change-function')
            change_function.setup({
                queries = {
                    -- go = 'function_params',
                    rust = 'function_params',
                    python = 'function_params',
                },
                languages = {
                    go = {
                        query_file = 'function_params',
                        argument_seperator = ', ',
                    },
                },
                mappings = {
                    add_argument = { 'a', 'i' },
                },
                nui = function(title)
                    return {
                        win_options = {
                            winhighlight = 'NormalFloat:Normal',
                        },
                        enter = true,
                        focusable = true,
                        border = {
                            style = 'rounded',
                            text = {
                                top = 'Changing argument of ' .. title,
                            },
                        },
                        position = '50%',
                        size = {
                            width = '40%',
                            height = '20%',
                        },
                        -- relative = 'editor',
                        zindex = 40,
                        buf_options = {
                            modifiable = false,
                            readonly = false,
                        },
                    }
                end,
            })

            vim.api.nvim_set_keymap('n', '<leader>csq', '', {
                callback = change_function.change_function_via_qf,
                desc = 'Change function signature via quickfix list',
            })

            vim.api.nvim_set_keymap('n', '<leader>css', 'Change function', {
                callback = change_function.change_function,
                desc = 'Change function signature',
            })
        end,
    },
}
