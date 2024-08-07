local colours = require "colours"

return {
    {
        'sainnhe/edge',
        init = function()
            vim.g.edge_style = 'aura'
            vim.g.edge_endable_italic = 1
            vim.g.edge_disable_italic_comment = 1
            vim.g.edge_diagnostic_virtual_text = 'colored'
        end
    },
    'morhetz/gruvbox',
    { 'dracula/vim',   name = 'dracula' },
    { 'sonph/onehalf', rtp = 'vim' },
    'matsuuu/pinkmare',
    'lifepillar/vim-solarized8',
    {
        'sainnhe/sonokai',
        init = function()
            vim.g.sonokai_style = 'shusia'
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_disable_italic_comment = 1
            vim.g.sonokai_diagnostic_virtual_text = 'colour_background'
        end
    },
    {
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup({
                on_highlights = function(hl, c)
                    hl['@markup.raw.markdown_inline'] = {
                        bg = colours.tuple_to_hex(colours.shade(colours.get_colour_tuple('Normal', 'bg'), 0.15)),
                        fg = '#7aa2fa',
                    }
                    hl.TelescopePromptBorder = {
                        bg = hl.TelescopeBorder.bg,
                        fg = hl.TelescopeBorder.fg,
                    }
                end,
            })
            -- vim.cmd [[highlight Cursor guifg=#000000 guibg=#FBC3BC]]
            -- vim.cmd [[highlight link TelescopeMatching Type]]
            vim.cmd([[colorscheme tokyonight-night]])
            vim.cmd([[highlight! link TelescopeSelection Define]])
            -- Icons become weird when bolded
            -- vim.cmd [[highlight TelescopeSelection guifg=#f0a6cc gui=bold]]
            vim.cmd([[highlight! TelescopeMatching guifg=#f6c177 gui=bold]])
            vim.cmd([[highlight! link FloatBorder NormalFloat]])
        end,
    },
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            fluo_color = "pink",
            mode = "normal",
            aggressive_spell = false,
        },
    },
    'EdenEast/nightfox.nvim',
    'joshdick/onedark.vim',
    {
        'rafamadriz/neon',
        init = function()
            vim.g.neon_style = 'default'
            vim.g.neon_italic_keyword = true
            vim.g.neon_italic_function = true
            vim.g.neon_transparent = true
        end
    },
    'tanvirtin/monokai.nvim',
    {
        'catppuccin/nvim',
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    navic = {
                        enabled = true,
                    }
                }
            })
        end,
    },
}
