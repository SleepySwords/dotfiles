return {
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
}
