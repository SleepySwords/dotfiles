local open_ft = require('keybindings').open_ft

return {
    --  File explorer
    {
        'nvim-tree/nvim-tree.lua',
        enabled = false,
        keys = {
            { open_ft.key,  '<cmd>NvimTreeToggle<CR>',   mode = { 'n' }, desc = open_ft.desc },
            { '<leader>ar', '<cmd>NvimTreeRefresh<CR>',  mode = { 'n' }, desc = 'Refresh File Tree' },
            { '<leader>an', '<cmd>NvimTreeFindFile<CR>', mode = { 'n' }, desc = 'Find Current File In Tree' },
        },
        dependencies = {
            'nvim-mini/mini.icons',
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
            confirmation = {
                border = 'single'
            }
        },
        dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    },
}
