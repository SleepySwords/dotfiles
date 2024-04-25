local M = {}

function M.setup()
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
end

return M
