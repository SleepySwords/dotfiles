return {
    --  Sensible default, that are no longer required (bless neovim)
    --  Thanks tpope for providing these defaults that I have used for many years!
    -- 'tpope/vim-sensible',

    {
        'mbbill/undotree',
        cmd = { "UndotreeFocus", "UndotreeHide", "UndotreePersistUndo", "UndotreeShow", "UndotreeToggle" },
        init = function()
            vim.g.undotree_SetFocusWhenToggle = true
        end,
    },

    {
        'nvim-mini/mini.icons',
        lazy = true,
        opts = {},
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },

    {
        'rcarriga/nvim-notify',
        optional = true,
        opts = {
            render = 'simple',
            stages = 'fade',
        },
    },

    -- Could just use ftplugins instead /shrug
    {
        'nvim-mini/mini.move',
        opts = {
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = '<C-h>',
                right = '<C-l>',
                down = '<C-j>',
                up = '<C-k>',

                -- Move current line in Normal mode
                line_left = '<M-h>',
                line_right = '<M-l>',
                line_down = '<C-j>',
                line_up = '<C-k>',
            },
        },
        version = false
    },
}
