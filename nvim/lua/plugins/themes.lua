local colours = require "colours"

return {
    'sainnhe/edge',
    'morhetz/gruvbox',
    { 'dracula/vim',   name = 'dracula' },
    { 'sonph/onehalf', rtp = 'vim' },
    'matsuuu/pinkmare',
    'lifepillar/vim-solarized8',
    'sainnhe/sonokai',
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
    'EdenEast/nightfox.nvim',
    'joshdick/onedark.vim',
    'rafamadriz/neon',
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
