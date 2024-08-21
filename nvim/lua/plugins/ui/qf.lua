return {
    {
        'kevinhwang91/nvim-bqf',
        enabled = false,
        opts = {
            preview = {
                border = 'single',
                win_height = 25,
            },
        },
    },
    {
        'arsham/listish.nvim',
        enabled = false,
        dependencies = {
            'arsham/arshlib.nvim',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            require('listish').config({})
        end,
    },
    {
        'stevearc/quicker.nvim',
        opts = {},
    },
}
