-- Adds dashboard
return {
    'glepnir/dashboard-nvim',
    -- event = 'VimEnter',
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
                    { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        desc = ' Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = ' Autosession load',
                        group = '@include',
                        action = 'Autosession search',
                        key = 'l',
                    },
                    {
                        desc = ' Autosession delete',
                        group = 'diffRemoved',
                        action = 'Autosession delete',
                        key = 'd',
                    },
                },
            },
        })
    end,
    dependencies = { 'echasnovski/mini.icons' },
};
