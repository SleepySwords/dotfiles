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
        'iamcco/markdown-preview.nvim',
        enabled = false,
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
        enabled = false,
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
        optional = true,
        opts = {
            render = 'simple',
            stages = 'fade',
        },
    },

    -- Could just use ftplugins instead /shrug
    'tpope/vim-sleuth',
    {
        'jbyuki/venn.nvim',
        config = function()
            -- venn.nvim: enable or disable keymappings
            function _G.Toggle_venn()
                local venn_enabled = vim.inspect(vim.b.venn_enabled)
                if venn_enabled == "nil" then
                    vim.b.venn_enabled = true
                    vim.cmd [[setlocal ve=all]]
                    -- draw a line on HJKL keystokes
                    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                    -- draw a box by pressing "f" with visual selection
                    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
                else
                    vim.cmd [[setlocal ve=]]
                    vim.api.nvim_buf_del_keymap(0, "n", "J")
                    vim.api.nvim_buf_del_keymap(0, "n", "K")
                    vim.api.nvim_buf_del_keymap(0, "n", "L")
                    vim.api.nvim_buf_del_keymap(0, "n", "H")
                    vim.api.nvim_buf_del_keymap(0, "v", "f")
                    vim.b.venn_enabled = nil
                end
            end

            -- toggle keymappings for venn using <leader>v
            vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true })
        end,
        ft = { 'markdown' },
    },
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
