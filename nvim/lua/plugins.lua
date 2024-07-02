return {
    --  Sensible default
    'tpope/vim-sensible',

    'mbbill/undotree',

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    --  File explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' }, --  for file icons
        config = function()
            require('navigation.tree').setup()
        end,
    },

    -- Buffers
    { 'ojroques/nvim-bufdel' },

    -- Git integration
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('octo').setup()
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",      -- optional
        },
        config = true
    },

    -- Discord rich presence
    {
        'andweeb/presence.nvim',
    },
    {
        dir = "/Users/ibby/stuff/dev/lua/change-function.nvim",
        dependencies = { 'MunifTanjim/nui.nvim' },
        config = function()
            local change_function = require("change-function")
            change_function.setup({
                mappings = {
                    quit = 'a'
                }
            })

            vim.api.nvim_set_keymap("n", "<leader>cr", "", {
                callback = change_function.change_function,
            })
        end,
    },

    -- Could just use ftplugins instead /shrug
    'tpope/vim-sleuth',
}

-- Plugins that need to try again
-- lsp_lines
-- Satellite.nvim (scrollbar)
-- Wilder.nvim (cmdline popup menu)
-- firenvim (in browser)
-- lukas-reineke/indent-blankline.nvim (add ident lines)
-- edgy.nvim
-- Harpoon
-- LspSaga
-- Fidget.nvim
-- noice.nvim (config at: ui.noice)
-- giusgad/pets.nvim (no cat)
--
-- mfussenegger/nvim-lint (never used)
-- simrat39/symbols-outline.nvim (never used)
--
-- The graveyard (rip)
-- Feline.nvim :(
-- lsputils
-- focus.nvim
-- folke/twilight.nvim
-- Rainbow braces
