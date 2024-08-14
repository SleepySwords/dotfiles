-- Adds LSP support
return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('completion.lsp')
        end,
    },

    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {}
    },

    -- Rust specific lsp extensions
    -- { 'mrcjkb/rustaceanvim' },

    'williamboman/mason.nvim',
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    -- Be able to add linters as formaters.
    {
        'jay-babu/mason-null-ls.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        config = function()
            require('mason-null-ls').setup({
                handlers = {},
            })
            require('null-ls').setup({})
        end,
    },

    -- Unfortunately the way decompilation works in omnisharp is that the client sends a
    -- o#/v2/gotodefinition request, which returns with a metadata source field, that is used
    -- in a o#/metadata request to get the decompilation. Unfortunately, LSP in neovim sends a
    -- textDocument/definition request, which doesn't return the metadata source, so either send another
    -- o#/v2/gotodefinition when recieving the textDocument/definition request or send a o#/v2/gotodefinition
    -- from the start, which is what is happening here with this plugin. Need to keep in mind that this uses
    -- two instances of omnisharp as a result.
    {
        'Hoffs/omnisharp-extended-lsp.nvim',
        lazy = true,
        ft = 'cs',
        config = function()
            require('completion.lsp_sources').setup_omni()
        end
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            require("completion.engine.nvim-cmp")
        end,
        dependencies = {
            -- Autocomplete Sources
            -- 'hrsh7th/cmp-cmdline', -- A bit annoying as it takes up the screen...
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',

            -- Adds icons to lsp variables
            'onsails/lspkind.nvim',
            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    'saadparwaiz1/cmp_luasnip',
                    'rafamadriz/friendly-snippets',
                },
                config = function()
                    require('luasnip').config.set_config({
                        history = true,
                        updateevents = 'TextChanged,TextChangedI',
                    })
                    require('luasnip.loaders.from_vscode').lazy_load()
                end,
            }
        },
    },

    -- Displays the function signature and current field.
    -- Keybind: <leader>k
    'ray-x/lsp_signature.nvim',
}
