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
}
