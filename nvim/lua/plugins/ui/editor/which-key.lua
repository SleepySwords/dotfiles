-- Interferes with the > and < keybindings
-- Displays the key that is present.
return {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function(_, opts)
        vim.o.timeoutlen = 500
        require('which-key').setup(opts)
    end,
    opts = {
        preset = 'helix',
        win = {
            border = 'none',
            padding = { 1, 3 },
            height = { min = 4, max = 20 },
            width = 60,
            title = true,
            title_pos = 'left',
            -- title_pos = "center",
        },
        spec = {
            { '<leader>x',  group = 'Trouble' },
            { '<leader>a',  group = 'Sessions/Grep' },
            { '<leader>d',  group = 'Debugger' },
            { '<leader>h',  group = 'Telescope items' },
            { '<leader>o',  group = 'Org mode' },
            { '<leader>c',  group = 'Code actions + Colourscheme' },
            { '<leader>co', group = 'Overseer (code runner)' },
            { '<leader>ct', group = 'Testing' },
            { '<leader>cw', group = 'LSP Workspaces' },
        },
        icons = {
            mappings = false,
        },
        delay = 0,
        keys = {
            scroll_down = '<c-d>', -- binding to scroll down inside the popup
            scroll_up = '<c-u>',   -- binding to scroll up inside the popup
        },
        -- triggers = ''
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = true })
            end,
            desc = "Keymaps (which-key)",
        },
    },
}
