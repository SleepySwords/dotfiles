return {
    --  Sensible default, that are no longer required (bless neovim)
    --  Thanks tpope for providing these defaults that I have used for many years!
    -- 'tpope/vim-sensible',

    {
        'mbbill/undotree',
        init = function()
            vim.g.undotree_SetFocusWhenToggle = true
        end,
    },

    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },

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
        config = function()
            require('navigation.tree').setup()
        end,
    },
    {
        'echasnovski/mini.icons',
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

    -- Buffers
    { 'ojroques/nvim-bufdel' },

    -- Git integration
    {
        'pwntester/octo.nvim',
        cmd = 'Octo',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'echasnovski/mini.icons',
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
        cmd = { 'Neogit', 'NeogitResetState' },

        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'sindrets/diffview.nvim', -- optional - Diff integration

            -- Only one of these is needed, not both.
            'nvim-telescope/telescope.nvim', -- optional
            'ibhagwan/fzf-lua', -- optional
        },
        opts = {
            graph_style = 'kitty',
        },
    },
    {
        'sindrets/diffview.nvim',
    },
    {
        'isakbm/gitgraph.nvim',
        enabled = false,
        dependencies = { 'sindrets/diffview.nvim' },
        opts = {
            symbols = {
                merge_commit = '',
                commit = '',
                merge_commit_end = '',
                commit_end = '',

                -- Advanced symbols
                GVER = '',
                GHOR = '',
                GCLD = '',
                GCRD = '╭',
                GCLU = '',
                GCRU = '',
                GLRU = '',
                GLRD = '',
                GLUD = '',
                GRUD = '',
                GFORKU = '',
                GFORKD = '',
                GRUDCD = '',
                GRUDCU = '',
                GLUDCD = '',
                GLUDCU = '',
                GLRDCL = '',
                GLRDCR = '',
                GLRUCL = '',
                GLRUCR = '',
                format = {},
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
        },
        init = function()
            vim.keymap.set('n', '<leader>gl', function()
                require('gitgraph').draw({}, { all = true, max_count = 5000 })
            end, { desc = 'new git graph' })
        end,
    },

    {
        'nvchad/showkeys',
        cmd = 'ShowkeysToggle',
        dependencies = { 'nvchad/volt' },
        opts = {
            position = 'bottom-right',
        },
    },

    { 'nvchad/timerly', enabled = false, cmd = 'TimerlyToggle' },

    -- Discord rich presence
    {
        'andweeb/presence.nvim',
        enabled = false,
    },
    {
        'Sleepyswords/change-function.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        config = function()
            local change_function = require('change-function')
            change_function.setup({
                queries = {
                    go = 'function_params',
                    rust = 'function_params',
                    python = 'function_params',
                },
                mappings = {
                    add_argument = { 'a', 'i' },
                },
                nui = function(title)
                    return {
                        win_options = {
                            winhighlight = 'NormalFloat:Normal',
                        },
                        enter = true,
                        focusable = true,
                        border = {
                            style = 'rounded',
                            text = {
                                top = 'Changing argument of ' .. title,
                            },
                        },
                        position = '50%',
                        size = {
                            width = '40%',
                            height = '20%',
                        },
                        -- relative = 'editor',
                        zindex = 40,
                        buf_options = {
                            modifiable = false,
                            readonly = false,
                        },
                    }
                end,
            })

            vim.api.nvim_set_keymap('n', '<leader>csq', '', {
                callback = change_function.change_function_via_qf,
                desc = 'Change function signature via quickfix list',
            })

            vim.api.nvim_set_keymap('n', '<leader>css', 'Change function', {
                callback = change_function.change_function,
                desc = 'Change function signature',
            })
        end,
    },
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        enabled = false,
        -- opts = {},
        config = function()
            require('persistence').setup({})
            local group = vim.api.nvim_create_augroup('user-persistence', { clear = true })
            vim.api.nvim_create_autocmd('user', {
                pattern = 'PersistenceLoadPost',
                group = group,
                callback = function()
                    if #vim.api.nvim_list_tabpages() >= 3 then
                        vim.g.has_setup_tabs = true
                    end
                    local tab_names = { 'Code', 'Debug', 'Terminal' }
                    for _, v in ipairs(vim.api.nvim_list_tabpages()) do
                        if tab_names[v] ~= nil then
                            vim.api.nvim_tabpage_set_var(v, 'name', tab_names[v])
                        end
                    end
                end,
            })
        end,
    },
    {
        'rmagatti/auto-session', -- Maybe replace with Shatur/neovim-session-manager or folke/persistence.nvim
        -- Perhaps even ahmedkhalf/project.nvim
        event = 'BufReadPre',
        cmd = { 'SessionSearch', 'Autosession' },
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
                    end,
                },
                post_restore_cmds = {
                    function()
                        local tab_names = { 'Code', 'Debug', 'Terminal' }
                        for _, v in ipairs(vim.api.nvim_list_tabpages()) do
                            if tab_names[v] ~= nil then
                                vim.api.nvim_tabpage_set_var(v, 'name', tab_names[v])
                            end
                        end
                    end,
                },
            })
        end,
    },
    -- {
    --     'folke/noice.nvim',
    --     -- event = 'VeryLazy',
    --     opts = {
    --         lsp = {
    --             signature = {
    --                 enabled = false,
    --             },
    --         },
    --         presets = {
    --             -- you can enable a preset by setting it to true, or a table that will override the preset config
    --             -- you can also add custom presets that you can enable/disable with enabled=true
    --             bottom_search = true,
    --         },
    --     },
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'rcarriga/nvim-notify',
    --     },
    -- },
    -- {
    --     'rcarriga/nvim-notify',
    --     opts = {
    --         render = 'simple',
    --         stages = 'fade',
    --     },
    -- },

    -- Could just use ftplugins instead /shrug
    'tpope/vim-sleuth',
    'jbyuki/venn.nvim',
    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        enabled = false,
        lazy = false,
        opts = {
            -- add any opts here
        },
        build = ':AvanteBuild', -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            --- The below dependencies are optional,
            'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
            -- 'zbirenbaum/copilot.lua', -- for providers='copilot'
            {
                -- support for image pasting
                'HakonHarnes/img-clip.nvim',
                event = 'VeryLazy',
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            -- {
        },
    },
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
