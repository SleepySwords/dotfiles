return {
    --  Sensible default, that are no longer required (bless neovim)
    --  Thanks tpope for providing these defaults that I have used for many years!
    -- 'tpope/vim-sensible',

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
        cmd = "NvimTreeToggle",
        config = function()
            require('navigation.tree').setup()
        end,
    },

    -- Buffers
    { 'ojroques/nvim-bufdel' },

    -- Git integration
    {
        'pwntester/octo.nvim',
        cmd = "Octo",
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
        cmd = { "Neogit", "NeogitResetState" },
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
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

            -- FIXME: maybe fr
            vim.api.nvim_set_keymap("n", "<leader>cr", "Change function", {
                callback = change_function.change_function,
                desc = "Change function signature"
            })
        end,
    },
    {
        "rmagatti/auto-session", -- Maybe replace with Shatur/neovim-session-manager or folke/persistence.nvim
        lazy = false,
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('auto-session').setup({
                auto_session_enabled = true,
                auto_restore_enabled = false,
                bypass_session_save_file_types = { 'dashboard' },
                session_lens = {
                    load_on_setup = true,
                    theme_conf = { border = true },
                    previewer = false,
                },
                pre_restore_cmds = {
                    function()
                        vim.g.has_setup_tabs = true
                    end
                },
                post_restore_cmds = {
                    function()
                        local tab_names = { "Code", "Debug", "Terminal" }
                        for _, v in ipairs(vim.api.nvim_list_tabpages()) do
                            if tab_names[v] ~= nil then
                                vim.api.nvim_tabpage_set_var(v, "name", tab_names[v]);
                            end
                        end
                    end
                }
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
-- huez.nvim
--
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
