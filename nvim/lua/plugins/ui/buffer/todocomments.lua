-- Highlights comments that are marked todo, fix, etc..
return {
    dir = '/Users/ibby/stuff/dev/lua/todo-comments.nvim/',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        require('todo-comments').setup({
            highlight = {
                pattern = [[.{-}<((KEYWORDS).{-})\s*:]],
            },
        })
    end,
};
