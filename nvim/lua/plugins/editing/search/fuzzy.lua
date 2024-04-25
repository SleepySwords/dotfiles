return {
    --  Fuzzy finders
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('navigation.telescope').setup()
        end,
    },
    'junegunn/fzf',
    'ibhagwan/fzf-lua',
}
