-- Interferes with the > and < keybindings
-- Displays the key that is present.
return {
    'willothy/which-key.nvim',
    branch = 'win-view-fix',
    config = function()
        require('ui.which_key').setup()
    end,
}
