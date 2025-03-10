return {
    --  Syntax + treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = 'gnn',
                        node_incremental = 'gnc',
                        scope_incremental = 'gnrc',
                        node_decremental = 'gnrm',
                    },
                },
                -- indent = {
                -- 	enable = true
                -- },
                rainbow = {
                    enable = true,
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['ia'] = '@parameter.inner',
                            ['aa'] = '@parameter.outer',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                        },
                    },
                },
            })
        end,
        run = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        after = 'nvim-treesitter',
    },

    {
        'aaronik/treewalker.nvim',

        keys = {
            { '<c-s-J>', '<cmd>Treewalker Down<cr>',      mode = 'n' },
            { '<c-s-K>', '<cmd>Treewalker Up<cr>',        mode = 'n' },
            { '<c-s-H>', '<cmd>Treewalker Left<cr>',      mode = 'n' },
            { '<c-s-L>', '<cmd>Treewalker Right<cr>',     mode = 'n' },

            -- Swapping Nodes in Visual Mode
            { 'mj',      '<cmd>Treewalker SwapDown<cr>',  mode = 'n', desc = 'Treesurfer swap next element', },
            { 'mk',      '<cmd>Treewalker SwapUp<cr>',    mode = 'n', desc = 'Treesurfer swap previous element' },
            { 'mh',      '<cmd>Treewalker SwapLeft<cr>',  mode = 'n', desc = 'Treesurfer swap previous element' },
            { 'ml',      '<cmd>Treewalker SwapRight<cr>', mode = 'n', desc = 'Treesurfer swap previous element' },
        },

        opts = {
            highlight = true,
            highlight_duration = 250,
            highlight_group = 'CursorLine',
        }
    },
    {
        'David-Kunz/treesitter-unit',
        keys = {
            { '<leader>ls', '<cmd>lua require"treesitter-unit".select()<cr>',     mode = { 'n', 'x', 'v' } },
            { '<leader>lS', '<cmd>lua require"treesitter-unit".select(true)<cr>', mode = { 'n', 'x', 'v' } }
        }
    },

    {
        'ziontee113/syntax-tree-surfer',
        enabled = false,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
        keys = {
            { '<leader>lm', '<cmd>STSSelectMasterNode<cr>',      mode = 'n', desc = 'Treesurfer select master node' },
            { '<leader>ln', '<cmd>STSSelectCurrentNode<cr>',     mode = 'n', desc = 'Treesurfer select current node' },
            { 'J',          '<cmd>STSSelectNextSiblingNode<cr>', mode = 'x' },
            { 'K',          '<cmd>STSSelectPrevSiblingNode<cr>', mode = 'x' },
            { 'H',          '<cmd>STSSelectParentNode<cr>',      mode = 'x' },
            { 'L',          '<cmd>STSSelectChildNode<cr>',       mode = 'x' },

            -- Swapping Nodes in Visual Mode
            { 'mj',         '<cmd>STSSwapNextVisual<cr>',        mode = 'x', desc = 'Treesurfer swap next element', },
            { 'mk',         '<cmd>STSSwapPrevVisual<cr>',        mode = 'x', desc = 'Treesurfer swap previous element' },
        }
    }
}
