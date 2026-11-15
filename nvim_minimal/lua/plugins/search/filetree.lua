local open_ft = require('keybindings').open_ft

return {
    {
        'stevearc/oil.nvim',
        opts = {
            view_options = {
                show_hidden = true,
            },
            confirmation = {
                border = 'single'
            }
        },
        dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    },
}
