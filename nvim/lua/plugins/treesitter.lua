return {
    --  Syntax + treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('ui.treesitter')
        end,
        run = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        after = 'nvim-treesitter',
    },

    {
        'ziontee113/syntax-tree-surfer',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('ui.treesurfer').setup()
        end,
    }
}
