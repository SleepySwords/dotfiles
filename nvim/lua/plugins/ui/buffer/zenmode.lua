-- Enter :ZenMode
return {
    'folke/zen-mode.nvim',
    opts = {
        window = {
            backdrop = 0.95,
            width = 100,
            height = 1,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,     -- disable relative numbers
                foldcolumn = "0",           -- disable fold column
            }
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
            },
            twilight = { enabled = false },
            gitsigns = { enabled = false },     -- disables git signs_staged
        },
    }
};
