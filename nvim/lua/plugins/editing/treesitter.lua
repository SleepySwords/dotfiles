return {
    --  Syntax + treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        config = function()
            require 'nvim-treesitter'.setup {
                install_dir = vim.fn.stdpath('data') .. '/site'
            }
            -- require('nvim-treesitter').install({ 'rust', 'javascript', 'zig', 'go', 'haskell' }):wait(300000)
        end,
        build = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    lookahead = true,
                }
            }

            local function define_select(keys, textobject)
                vim.keymap.set({ "x", "o" }, keys, function()
                    require "nvim-treesitter-textobjects.select".select_textobject(textobject, "textobjects")
                end)
            end

            define_select('ia', '@parameter.inner')
            define_select('aa', '@parameter.outer')
            define_select('ac', '@class.outer')
            define_select('ic', '@class.inner')
            define_select('af', '@function.outer')
            define_select('if', '@function.inner')

            define_select('as', '@local.scope')
        end,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        after = 'nvim-treesitter',
    },

    {
        'aaronik/treewalker.nvim',
        config = function()
            require 'treewalker'.setup {

                highlight = true,
                highlight_duration = 250,
                highlight_group = 'CursorLine',

                select = true,
            }
            vim.keymap.set({ 'n' }, "mj", "<cmd>Treewalker SwapDown<cr>",
                { noremap = true, desc = 'Treesurfer swap previous element' })
            vim.keymap.set({ 'n' }, "mk", "<cmd>Treewalker SwapUp<cr>",
                { noremap = true, desc = 'Treesurfer swap previous element' })
            vim.keymap.set({ 'n' }, "mh", "<cmd>Treewalker SwapLeft<cr>",
                { noremap = true, desc = 'Treesurfer swap previous element' })
            vim.keymap.set({ 'n' }, "ml", "<cmd>Treewalker SwapRight<cr>",
                { noremap = true, desc = 'Treesurfer swap previous element' })

            function _G.Toggle_treewalker()
                local venn_enabled = vim.inspect(vim.b.treewalker_enabled)
                if venn_enabled == "nil" then
                    vim.b.treewalker_enabled = true
                    vim.keymap.set({ 'n', 'x', 'v' }, "J", "<cmd>Treewalker Down<cr>", { noremap = true, buffer = 0 })
                    vim.keymap.set({ 'n', 'x', 'v' }, "K", "<cmd>Treewalker Up<cr>", { noremap = true, buffer = 0 })
                    vim.keymap.set({ 'n', 'x', 'v' }, "L", "<cmd>Treewalker Right<cr>", { noremap = true, buffer = 0 })
                    vim.keymap.set({ 'n', 'x', 'v' }, "H", "<cmd>Treewalker Left<cr>", { noremap = true, buffer = 0 })
                    vim.keymap.set({ 'n', 'x', 'v' }, "<esc>", function()
                        Toggle_treewalker()
                    end, { noremap = true, buffer = 0 })
                else
                    vim.keymap.del({ 'n', 'x', 'v' }, "J", { buffer = 0 })
                    vim.keymap.del({ 'n', 'x', 'v' }, "K", { buffer = 0 })
                    vim.keymap.del({ 'n', 'x', 'v' }, "L", { buffer = 0 })
                    vim.keymap.del({ 'n', 'x', 'v' }, "H", { buffer = 0 })
                    vim.keymap.del({ 'n', 'x', 'v' }, "<esc>", { buffer = 0 })
                    vim.api.nvim_input('<ESC>')
                    vim.b.treewalker_enabled = nil
                end
            end

            vim.keymap.set('n', '<leader>e', function()
                Toggle_treewalker()
            end, { noremap = true })
        end,
    },
    {
        'David-Kunz/treesitter-unit',
        keys = {
            { '<leader>ls', function() require "treesitter-unit".select() end,     mode = { 'n', 'x', 'v' } },
            { '<leader>lS', function() require "treesitter-unit".select(true) end, mode = { 'n', 'x', 'v' } }
        }
    },

    {
        'ziontee113/syntax-tree-surfer',
        enabled = false,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            select = true,
        },
        keys = {
            { '<leader>lm', '<cmd>STSSelectMasterNode<cr>',      mode = 'n', desc = 'Treesurfer select master node' },
            { '<leader>ln', '<cmd>STSSelectCurrentNode<cr>',     mode = 'n', desc = 'Treesurfer select current node' },
            { 'J',          '<cmd>STSSelectNextSiblingNode<cr>', mode = 'x' },
            { 'K',          '<cmd>STSSelectPrevSiblingNode<cr>', mode = 'x' },
            { 'H',          '<cmd>STSSelectParentNode<cr>',      mode = 'x' },
            { 'L',          '<cmd>STSSelectChildNode<cr>',       mode = 'x' },

            -- Swapping Nodes in Visual Mode
            { 'mj',         '<cmd>STSSwapNextVisual<cr>',        mode = 'x', desc = 'Treesurfer swap next element', },
            { 'mk',         '<cmd>STSSwapPrevVisual<cr>',        mode = 'x', desc = 'Treesurfer swap previous element' },
        }
    }
}
