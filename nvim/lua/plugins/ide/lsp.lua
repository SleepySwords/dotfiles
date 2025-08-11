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
        opts = {},
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
    {
        'jay-babu/mason-null-ls.nvim',
        enabled = false,
        event = { 'BufReadPre', 'BufNewFile' },
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
    -- Be able to add linters as formaters.
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
            require('completion.lsp_servers').setup_omni()
        end,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        enabled = false,
        event = 'InsertEnter',
        config = function()
            require('completion.engine.nvim-cmp')
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
            },
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'mini.icons',
            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    'rafamadriz/friendly-snippets',
                },
                config = function()
                    require('luasnip').config.set_config({
                        history = true,
                        updateevents = 'TextChanged,TextChangedI',
                    })
                    require('luasnip.loaders.from_vscode').lazy_load()
                end,
            },
        },
        version = '*',
        opts = {
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { function()
                    local luasnip = require('luasnip')
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                        return true
                    else
                        return false
                    end
                end, 'fallback' }
            },

            appearance = {
                -- use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon" }, { "label" --[[ , "label_description" ]], gap = 1 }, { "kind", gap = 1 }
                        },
                        components = {
                            kind = {
                                ellipsis = false,
                                width = { fill = true },
                                text = function(ctx) return ctx.kind end,
                            },
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return kind_icon
                                end,
                                -- Optionally, you may also use the highlights from mini.icons
                                highlight = function(ctx)
                                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return hl
                                end,
                            }
                        }
                    }
                },
                documentation = {
                    auto_show = true,
                },
                ghost_text = {
                    enabled = true,
                },
                list = {
                    selection =
                    {
                        auto_insert = true,
                        preselect = function(ctx)
                            return ctx.mode ~= 'cmdline' and vim.bo[ctx.bufnr].filetype ~= 'DressingInput'
                        end,
                    }

                }
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_insert = true,
                    show_on_keyword = true,
                }
            },
            snippets = { preset = 'luasnip' },
        },
        opts_extend = { 'sources.default' },
    },

    -- Displays the function signature and current field.
    -- Keybind: <leader>k
    {
        'ray-x/lsp_signature.nvim',
        enabled = false,
        opts = {
            log_path = vim.fn.expand('$HOME') .. '/tmp/sig.log',
            -- debug = true,
            hint_enable = false,
            -- noice = true,
            doc_lines = 10,
            padding = ' ',
            max_width = 160,
            max_height = 1200,

            handler_opts = {
                border = 'solid',
            },
            toggle_key = '<M-k>',
            -- toggle_key_flip_floatwin_setting = true,
            select_signature_key = '<M-n>',
            move_cursor_key = '<M-p>',
            cursorhold_update = false,
            debug = true,
        },
    },
    {
        'Issafalcon/lsp-overloads.nvim',
        enabled = false,
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp_overloads', {}),
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client ~= nil and client.server_capabilities.signatureHelpProvider then
                        require('lsp-overloads').setup(client, {})
                    end
                end,
            })
        end,
    },
}
