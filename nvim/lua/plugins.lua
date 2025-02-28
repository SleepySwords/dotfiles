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

    -- Buffers
    { 'ojroques/nvim-bufdel' },

    {
        'nvchad/showkeys',
        cmd = 'ShowkeysToggle',
        dependencies = { 'nvchad/volt' },
        opts = {
            position = 'bottom-right',
        },
    },

    { 'nvchad/timerly',      enabled = false, cmd = 'TimerlyToggle' },

    -- Discord rich presence
    {
        'andweeb/presence.nvim',
        enabled = false,
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
    {
        'rcarriga/nvim-notify',
        enabled = false,
        opts = {
            render = 'simple',
            stages = 'fade',
        },
    },

    -- Could just use ftplugins instead /shrug
    'tpope/vim-sleuth',
    {
        'jbyuki/venn.nvim',
        ft = { 'markdown' },
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
