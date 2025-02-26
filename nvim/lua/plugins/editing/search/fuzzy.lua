return {
    --  Fuzzy finders
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('navigation.telescope').setup()
        end,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {'junegunn/fzf', enabled = false},
    {'ibhagwan/fzf-lua', enabled = false},
}
