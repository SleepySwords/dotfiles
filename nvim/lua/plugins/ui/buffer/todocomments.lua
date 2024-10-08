-- Highlights comments that are marked todo, fix, etc..
return {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        require('todo-comments').setup({
            highlight = {
                pattern = [[.{-}<((KEYWORDS).{-})\s*:]],
            },
        })
    end,
};
