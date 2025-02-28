return {
    -- Git integration
    {
        'pwntester/octo.nvim',
        cmd = 'Octo',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'echasnovski/mini.icons',
        },
        config = function()
            require('octo').setup()
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'NeogitOrg/neogit',
        cmd = { 'Neogit', 'NeogitResetState' },

        dependencies = {
            'nvim-lua/plenary.nvim',  -- required
            'sindrets/diffview.nvim', -- optional - Diff integration

            -- Only one of these is needed, not both.
            'nvim-telescope/telescope.nvim', -- optional
            -- 'ibhagwan/fzf-lua', -- optional
        },
        opts = {
            graph_style = 'kitty',
        },
    },
    {
        'sindrets/diffview.nvim',
    },
    {
        'isakbm/gitgraph.nvim',
        enabled = false,
        dependencies = { 'sindrets/diffview.nvim' },
        opts = {
            symbols = {
                merge_commit = '',
                commit = '',
                merge_commit_end = '',
                commit_end = '',

                -- Advanced symbols
                GVER = '',
                GHOR = '',
                GCLD = '',
                GCRD = '╭',
                GCLU = '',
                GCRU = '',
                GLRU = '',
                GLRD = '',
                GLUD = '',
                GRUD = '',
                GFORKU = '',
                GFORKD = '',
                GRUDCD = '',
                GRUDCU = '',
                GLUDCD = '',
                GLUDCU = '',
                GLRDCL = '',
                GLRDCR = '',
                GLRUCL = '',
                GLRUCR = '',
                format = {},
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
        },
        init = function()
            vim.keymap.set('n', '<leader>gl', function()
                require('gitgraph').draw({}, { all = true, max_count = 5000 })
            end, { desc = 'new git graph' })
        end,
    },

}
