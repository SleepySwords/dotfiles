return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    config = function()
        vim.api.nvim_set_hl(0, 'FlashLabel', { bold = true, ctermfg = 45, fg = '#ff007c' })
        vim.api.nvim_set_hl(0, 'FlashKey1', { bold = true, ctermfg = 45, fg = '#00dfff' })
        vim.api.nvim_set_hl(0, 'FlashKey2', { bold = true, ctermfg = 45, fg = '#2b8db3' })
        require('flash').setup({
            label = {
                -- style = "inline"
                -- rainbow = {
                -- 	enabled = true
                -- }
            },
            modes = {
                char = {
                    highlight = {
                        backdrop = false,
                    },
                    keys = {
                        ["f"] = "sf",
                        ["F"] = "sF",
                        ["t"] = "st",
                        ["T"] = "sT",
                        [";"] = "s;",
                        [","] = "s,"
                    },
                },
            },
        })
    end,
    keys = {
        {
            'sj',
            mode = { 'n', 'o', 'x' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
    },
}
