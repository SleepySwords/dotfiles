return {
    -- Adds trouble which displays references, diagnostics
    'folke/trouble.nvim',
    dependencies = 'echasnovski/mini.icons',
    config = function()
        require('trouble').setup({
            action_keys = {
                jump = { '<tab>' },
                jump_close = { 'o', '<cr>' },
            },
        })
    end,
};
