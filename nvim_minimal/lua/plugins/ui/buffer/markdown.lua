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
        ft = "markdown",
        opts = {
            document = {
                enabled = false,
            },
            checkbox = {
                enabled = false,
            },
            heading = {
                icons = {},
            },
            win_options = {
                conceallevel = {
                    default = vim.o.conceallevel,
                    rendered = vim.o.conceallevel,
                },
                concealcursor = {
                    default = vim.o.concealcursor,
                    rendered = vim.o.concealcursor,
                },
            },
            code = {
                conceal_delimiters = false,
                above = '▄',
                -- Used below code blocks for thin border.
                below = '▀',
                border = 'thin',
                inline = true,
                inline_left = '',
                -- Icon to add to the right of inline code.
                inline_right = '',
            },
            pipe_table = {
                style = 'normal',
            },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
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
            'nvim-mini/mini.icons',
        },
    },
}
