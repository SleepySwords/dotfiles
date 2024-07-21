-- Interferes with the > and < keybindings
-- Displays the key that is present.
return {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
        require('ui.which_key').setup()
    end,
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
