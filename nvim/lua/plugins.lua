return {
    --  Sensible default
    'tpope/vim-sensible',

    -- Adds LSP support
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Adds neovim docs to lsp
            'folke/neodev.nvim',
        },
        config = function()
            require('completion.lsp')
        end,
    },
    'williamboman/mason.nvim',
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        config = function()
            require('completion.mason').setup()
        end,
    },

    -- Be able to add linters as formaters.
    {
        'jay-babu/mason-null-ls.nvim',
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

    'mbbill/undotree',

    -- Adds better defaults for LSP
    {
        'RishabhRD/nvim-lsputils',
        dependencies = {
            'RishabhRD/popfix',
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('completion.lsp_utils').setup()
        end,
    },

    -- Improves the vim.ui stuff, such as vim.ui.input() (gr)
    {
        'stevearc/dressing.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('ui.dressing').setup()
        end,
    },

    -- Adds trouble which displays references, diagnostics
    {
        'folke/trouble.nvim',
        branch = 'dev',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('trouble').setup({
                action_keys = {
                    jump = { '<tab>' },
                    jump_close = { 'o', '<cr>' },
                },
            })
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
    'hrsh7th/nvim-cmp',

    -- Autocomplete Sources
    -- 'hrsh7th/cmp-cmdline', -- A bit annoying as it takes up the screen...
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',

    -- Displays the function signature and current field.
    -- Keybind: <leader>k
    'ray-x/lsp_signature.nvim',

    -- Adds icons to lsp variables
    'onsails/lspkind.nvim',

    --  Syntax + treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('ui.treesitter')
        end,
        run = ':TSUpdate',
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = {
            markdown = {
                bullets = {
                    "●" },
                bullet_highlights = {
                    "@text.title.1.markdown",
                    "@text.title.2.markdown",
                    "@text.title.3.markdown",
                    "@text.title.4.markdown",
                    "@text.title.5.markdown",
                    "@text.title.6.markdown",
                },
                fat_headline_lower_string = '▔',
                headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4" },
            }
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        after = 'nvim-treesitter',
    },

    {
        'ziontee113/syntax-tree-surfer',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('ui.treesurfer').setup()
        end,
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

    --  Debugging
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-telescope/telescope-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            require('dbg.dap').setup()
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            "nvim-neotest/nvim-nio",
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('dbg.dap_ui').setup()
        end,
    },
    -- Add ability to debug lua plugins
    'jbyuki/one-small-step-for-vimkind',

    -- { 'mfussenegger/nvim-lint' },


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

    -- Highlight variables with the same name.
    {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure({
                providers = {
                    'lsp',
                },
                delay = 0,
            })
        end,
    },

    -- Discord rich presence
    {
        'andweeb/presence.nvim',
    },

    -- Adds folds for lsp, treesitter, mainly functions
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            require('ui.ufo').setup()
        end,
    },

    -- Adds statuscol plugin, allows for the down arrow folds.
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require('statuscol.builtin')
            require('statuscol').setup({
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
                    { text = { '%s' },                  click = 'v:lua.ScSa' },
                    { text = { '%s' },                  click = 'v:lua.ScSa' },
                    { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                },
            })
        end,
    },

    -- Interferes with the > and < keybindings
    -- Displays the key that is present.
    {
        'willothy/which-key.nvim',
        branch = 'win-view-fix',
        config = function()
            require('ui.which_key').setup()
        end,
    },

    -- Highlights comments that are marked todo, fix, etc..
    {
        dir = '/Users/ibby/stuff/dev/lua/todo-comments.nvim/',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup({
                highlight = {
                    pattern = [[.{-}<((KEYWORDS).{-})\s*:]],
                },
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
-- Prob not going to try again
-- beauwilliams/focus.nvim
-- Feline.nvim :(
-- folke/twilight.nvim
-- Rainbow braces
