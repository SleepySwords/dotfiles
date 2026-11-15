local colours = require('utils.colours')

return {
    {
        'catppuccin/nvim',
        lazy = true,
        config = function()
            require('catppuccin').setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    navic = {
                        enabled = true,
                    },
                },
            })
        end,
    },
}
