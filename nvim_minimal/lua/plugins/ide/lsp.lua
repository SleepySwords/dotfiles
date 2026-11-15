-- Adds LSP support
return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('completion.lsp')
        end,
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
}
