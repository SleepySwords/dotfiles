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
    -- Adds folds for lsp, treesitter, mainly functions
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        opts = {
            provider_selector = function(_, filetype, _)
                if filetype == 'markdown' then
                    return { 'treesitter', 'indent' }
                else
                    return { 'lsp', 'indent' }
                end
            end,
            fold_virt_text_handler = require('utils.ufo_handler').handler,
        }
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
        'nvim-lua/lsp-status.nvim',
        config = function()
            local lsp_status = require('lsp-status')
            lsp_status.config({
                status_symbol = '',
                diagnostics = false,
            })
            lsp_status.register_progress()

            vim.api.nvim_create_augroup('LspAttach_status', {})

            vim.api.nvim_create_autocmd('LspAttach', {
                group = 'LspAttach_status',
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    lsp_status.on_attach(client)
                end,
            })
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
