return {
    --  File explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'echasnovski/mini.icons',
            {
                'antosha417/nvim-lsp-file-operations',
                dependencies = {
                    'nvim-lua/plenary.nvim',
                },
                config = function()
                    require('lsp-file-operations').setup()
                end,
            },
        },
        cmd = 'NvimTreeToggle',
        opts = {

            view = {
                side = 'right',
            },
            git = {
                enable = false,
            },
            actions = {
                open_file = {
                    resize_window = true,
                    quit_on_open = true,
                },
            },
            renderer = {
                full_name = true,
                group_empty = true,
                special_files = {},
                symlink_destination = false,
                indent_markers = {
                    enable = true,
                },
                icons = {
                    git_placement = 'signcolumn',
                },
            },
        },
    },
    {
        'stevearc/oil.nvim',
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
        -- Optional dependencies
        dependencies = { { 'echasnovski/mini.icons', opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
}
