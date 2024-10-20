return {
    {
        'lukas-reineke/headlines.nvim',
        ft = 'markdown',
        enabled = false,
        lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {
            markdown = {
                bullets = {},
                bullet_highlights = {
                    '@text.title.1.markdown',
                    '@text.title.2.markdown',
                    '@text.title.3.markdown',
                    '@text.title.4.markdown',
                    '@text.title.5.markdown',
                    '@text.title.6.markdown',
                },
                fat_headline_lower_string = '',
                fat_headline_upper_string = '',
                headline_highlights = { 'Headline1', 'Headline2', 'Headline3', 'Headline4' },
            },
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- enabled = false,
        ft = "markdown",
        opts = {
            heading = {
                icons = {},
            },
            code = {
                above = ' ',
                -- Used below code blocks for thin border
                below = ' ',
            },
            pipe_table = {
                style = 'normal'
            },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },

    {
        'OXY2DEV/markview.nvim',
        enabled = false,
        opts = {
            modes = { 'n', 'i', 'c' },
            hybrid_modes = { 'n', 'i' },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.icons',
        },
    },
}
