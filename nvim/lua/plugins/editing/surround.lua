-- Surround commands (ysiw')
-- Keybinds: ys, ds, cs,
return {
    'kylechui/nvim-surround',
    config = function()
        require('nvim-surround').setup()
    end,
}
