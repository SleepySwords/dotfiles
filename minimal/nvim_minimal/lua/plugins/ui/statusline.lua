return {
    {
        'rebelot/heirline.nvim',
        dependencies = {
            'nvim-lua/lsp-status.nvim',
            'SmiteshP/nvim-navic',
            'nvim-mini/mini.icons',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            vim.api.nvim_create_augroup('Scheme', {})
            vim.api.nvim_create_autocmd('UIEnter', {
                group = 'Scheme',
                callback = function()
                    require('utils.statusline.heirline').setup()
                    vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
                        callback = function()
                            require('utils.statusline.heirline').setup()
                        end,
                    })
                end,
            })
        end,
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            local navic = require('nvim-navic')
            vim.api.nvim_set_hl(0, 'NavicSeparator', { fg = '#D8CFAF' })
            navic.setup({
                separator = ' -> ',
                highlight = true,
                lsp = {
                    auto_attach = true
                },
                icons = {
                    File = ' ',
                    Module = ' ',
                    Namespace = ' ',
                    Package = ' ',
                    Class = ' ',
                    Method = ' ',
                    Property = ' ',
                    Field = ' ',
                    Constructor = ' ',
                    Enum = ' ',
                    Interface = ' ',
                    Function = ' ',
                    Variable = ' ',
                    Constant = ' ',
                    String = ' ',
                    Number = ' ',
                    Boolean = ' ',
                    Array = ' ',
                    Object = ' ',
                    Key = ' ',
                    Null = ' ',
                    EnumMember = ' ',
                    Struct = ' ',
                    Event = ' ',
                    Operator = ' ',
                    TypeParameter = ' ',
                },
            })
        end,
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-mini/mini.icons',
        opts = {
            options = {
                close_icon = '',
                buffer_close_icon = '',
                numbers = 'buffer_id',
            },
        },
    },
}
