return {
    {
        'rebelot/heirline.nvim',
        dependencies = {
            'nvim-lua/lsp-status.nvim',
            'SmiteshP/nvim-navic',
            'echasnovski/mini.icons',
            'lewis6991/gitsigns.nvim',
            'kevinhwang91/nvim-ufo',
        },
        config = function()
            vim.api.nvim_create_augroup('Scheme', {})
            vim.api.nvim_create_autocmd('UIEnter', {
                group = 'Scheme',
                callback = function()
                    require('ui.statusline.heirline').setup()
                    vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
                        callback = function()
                            require('ui.statusline.heirline').setup()
                        end,
                    })
                end,
            })
        end,
    },
    -- Adds folds for lsp, treesitter, mainly functions
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            require('ui.ufo').setup()
        end,
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('ui.navic').setup()
        end,
    },
    {
        'nvim-lua/lsp-status.nvim',
        config = function()
            require('ui.lsp_status').setup()
        end,
    },
    {
        'akinsho/bufferline.nvim',
        -- version = "*",
        dependencies = 'echasnovski/mini.icons',
        opts = {
            options = {
                close_icon = '',
                buffer_close_icon = '',
                numbers = 'buffer_id',
            },
        },
    },
}
