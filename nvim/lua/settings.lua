-- Vim options
local o = vim.o

local function set_ft_option(ft, option, value)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = vim.api.nvim_create_augroup('FtOptions', {}),
        desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
        callback = function()
            vim.opt_local[option] = value
        end,
    })
end

-- Vim options setup
set_ft_option('markdown', 'spell', true)
set_ft_option('markdown', 'linebreak', true)

o.compatible = false
o.nu = true
o.rnu = true
o.completeopt = 'menuone,noinsert,noselect'
o.shortmess = o.shortmess .. 'c'
o.autoindent = true
o.smartindent = true
o.cmdheight = 1
o.updatetime = 500
o.signcolumn = 'yes'
o.clipboard = 'unnamed,unnamedplus'
o.showmatch = true
o.showtabline = 3
o.termguicolors = true
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.mouse = 'a'
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
o.hidden = true
o.guifont = 'Jetbrains Mono:h11'

o.foldcolumn = '1'
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

o.laststatus = 3
o.mousemodel = 'extend'
o.ignorecase = true
o.conceallevel = 3

-- Formatting
o.shiftwidth = 4
o.tabstop = 4


local g = vim.g

-- Global settings

-- Theme settings
-- Good themes: duskfox, onedark, sonokai, tokyonight-night(used for longest time)
g.edge_style = 'aura'
g.edge_endable_italic = 1
g.edge_disable_italic_comment = 1
g.sonokai_style = 'shusia'
g.sonokai_enable_italic = 1
g.sonokai_disable_italic_comment = 1
g.sonokai_diagnostic_virtual_text = 'colour_background'
g.neon_style = 'default'
g.neon_italic_keyword = true
g.neon_italic_function = true
g.neon_transparent = true

-- vim.cmd([[colorscheme catppuccin-mocha]])
vim.cmd([[colorscheme catppuccin-latte]])
g.telescope_theme = require('navigation.telescope').get_telescope_theme()

if vim.g.neovide then
    -- vim.cmd([[colorscheme duskfox]])
    vim.cmd([[colorscheme catppuccin-latte]])
    vim.g.neovide_floating_blur_amount_x = 0.0
    vim.g.neovide_floating_blur_amount_y = 0.0
    vim.g.neovide_padding_top = 5
    vim.g.neovide_padding_bottom = 5
end
-- Neovide
-- g.neovide_fullscreen = true
-- g.neovide_transparency = 0.9

-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = { 'exact', 'substring', 'fuzzy' }

g.indent_blankline_show_first_indent_level = false
g.Illuminate_ftblacklist = { 'NvimTree', 'dashboard' }

g.discord = false
g.indicator_ok = ''
