-- Surround commands (ysiw')
-- Keybinds: ys, ds, cs,
local keymaps = {
    -- insert          = '<C-g>z',
    -- insert_line     = 'gC-ggZ',
    normal = 'gsa',
    normal_cur = 'gSa',
    normal_line = 'gsgs',
    normal_cur_line = 'gSgS',
    visual = 'gsa',
    visual_line = 'gSa',
    delete = 'gsd',
    change = 'gsc',
}
return {
    {
        'kylechui/nvim-surround',
        config = function(_, opts)
            require('nvim-surround').setup(opts)
            vim.keymap.set({'n', 'v'}, 's', '<nop>', {})
        end,
        opts = {
            -- FIXME: may change this to omit the g, having flash use the g instead.
            keymaps = {
                -- insert          = '<C-g>z',
                -- insert_line     = 'gC-ggZ',
                normal = 'sa',
                normal_cur = 'sla',
                normal_line = 'sna',
                normal_cur_line = 'slna',
                visual = 'sa',
                visual_line = 'sla',
                delete = 'sd',
                change = 'sc',
                change_line = 'scl',
            },
        },
    },

    { 'echasnovski/mini.surround', enabled = false, version = false },
}
