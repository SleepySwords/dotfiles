-- Surround commands (ysiw')
-- Keybinds: ys, ds, cs,
return {
    {
        'kylechui/nvim-surround',
        opts = {
            -- FIXME: may change this to omit the g, having flash use the g instead.
            keymaps = {
                -- insert          = '<C-g>z',
                -- insert_line     = 'gC-ggZ',
                normal          = 'gsa',
                normal_cur      = 'gSa',
                normal_line     = 'gsgs',
                normal_cur_line = 'gSgS',
                visual          = 'gsa',
                visual_line     = 'gSa',
                delete          = 'gsd',
                change          = 'gsc',
            }
        }
    },

    { 'echasnovski/mini.surround', version = false },
}
