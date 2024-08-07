-- Highlight variables with the same name.
return {
    'RRethy/vim-illuminate',
    init = function()
        vim.g.Illuminate_ftblacklist = { 'NvimTree', 'dashboard' }
        vim.g.indent_blankline_show_first_indent_level = false
    end,
    config = function()
        require('illuminate').configure({
            providers = {
                'lsp',
            },
            delay = 0,
        })
    end,
};
