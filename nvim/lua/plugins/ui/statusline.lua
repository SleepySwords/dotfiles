return {
    {
        'rebelot/heirline.nvim',
        dependencies = {
            'nvim-lua/lsp-status.nvim',
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            vim.api.nvim_create_augroup('Scheme', {})
            vim.api.nvim_create_autocmd('UIEnter', {
                group = 'Scheme',
                callback = function()
                    require('ui.statusline.heirline')
                end,
            })
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
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup {}
        end
    },
}
