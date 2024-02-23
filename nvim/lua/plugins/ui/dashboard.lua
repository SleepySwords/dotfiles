-- Adds dashboard
return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        local g = vim.g

        local db = require('dashboard')
        require('splash_sprites')

        db.setup({
            theme = 'hyper',
            disable_move = true,
            config = {
                header = g.portal_cake,
                shortcut = {
                    { desc = ' Update', group = '@property', action = 'PackerUpdate', key = 'u' },
                    {
                        desc = ' Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    -- {
                    -- 	desc = ' dotfiles',
                    -- 	group = 'Number',
                    -- 	action = 'Telescope dotfiles',
                    -- 	key = 'd',
                    -- },
                },
            },
        })
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
};
