-- Improves the vim.ui stuff, such as vim.ui.input() (gr)
return {
    'stevearc/dressing.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('ui.dressing').setup()
    end,
};
