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
                    hl['@text.literal.markdown_inline'] = {
                        bg = '#151612',
                        fg = '#7aa2fa',
                    }
                end,
            })
            vim.cmd([[colorscheme tokyonight-night]])

            -- vim.cmd [[highlight Cursor guifg=#000000 guibg=#FBC3BC]]
            -- vim.cmd [[highlight link TelescopeMatching Type]]
            vim.cmd([[highlight! link TelescopeSelection Define]])
            -- Icons become weird when bolded
            -- vim.cmd [[highlight TelescopeSelection guifg=#f0a6cc gui=bold]]
            vim.cmd([[highlight! TelescopeMatching guifg=#f6c177 gui=bold]])
            vim.cmd([[highlight! link FloatBorder NormalFloat]])
            vim.api.nvim_set_hl(0, '@text.title.1.markdown', { fg = '#cb7676', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.1.marker.markdown', { fg = '#cb7676', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.2.markdown', { fg = '#c99076', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.2.marker.markdown', { fg = '#c99076', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.3.markdown', { fg = '#80a665', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.3.marker.markdown', { fg = '#80a665', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.4.markdown', { fg = '#4c9a91', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.4.marker.markdown', { fg = '#4c9a91', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.5.markdown', { fg = '#6893bf', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.5.marker.markdown', { fg = '#6893bf', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.6.markdown', { fg = '#d3869b', bold = true })
            vim.api.nvim_set_hl(0, '@text.title.6.marker.markdown', { fg = '#d3869b', bold = true })
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
