-- Highlight variables with the same name.
return {
    'RRethy/vim-illuminate',
    config = function()
        require('illuminate').configure({
            providers = {
                'lsp',
            },
            delay = 0,
        })
    end,
};
