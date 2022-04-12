local o = vim.o
local g = vim.g
local cmd = vim.cmd

require('plugins')

if not g.bootstrap then
    require('completion.lsp')
    require('ui.ui')
    require('config.navigation')
    require('config.miscellaneous')
    require('keybindings')
    require('dbg.dbg')
end

-- Vim options setup
o.compatible = false
o.nu = true
o.rnu = true
o.completeopt = "menuone,noinsert,noselect"
o.shortmess = o.shortmess .. "c"
o.shiftwidth = 4
o.autoindent = true
o.smartindent = true
o.cmdheight = 2
o.updatetime = 500
o.signcolumn = "yes"
o.clipboard = "unnamed,unnamedplus"
o.showmatch =  true
o.termguicolors = true
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.mouse = 'a'
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
o.hidden = true
o.termguicolors = true
o.guifont = 'Jetbrains Mono,Hack Nerd Font:l14'
-- opt('guifont', 'Hack Nerd Font:l')
-- opt('foldmethod', 'expr')
-- opt('foldexpr', 'nvim_treesitter#foldexpr()')
-- opt('expandtab', true)
-- opt('tabstop', 4)


-- Highlights when yannking (y)
cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)


-- Global settings
-- Theme settings
if not g.bootstrap then
    g.edge_style = 'aura'
    g.edge_endable_italic = 1
    g.edge_disable_italic_comment = 1
    g.sonokai_style = 'shusia'
    g.sonokai_enable_italic = 1
    g.sonokai_disable_italic_comment = 1
    g.sonokai_diagnostic_virtual_text = 'colour_background'
    g.colors_name = 'sonokai'
    cmd[[colorscheme sonokai]]
    g.telescope_theme = require("ui.telescope").get_theme()
end
-- g.colors_name = 'tokyonight'
-- g.colors_name = 'edge'
-- g.telescope_theme = require("telescope.themes").get_ivy()

-- Plugin settings
g.ultest_fail_sign = ''
g.ultest_pass_sign = ''

-- Neovide
g.neovide_fullscreen = true

-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.ale_linters = {cs = 'OmniSharp'}
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = {'exact', 'substring', 'fuzzy'}

-- Discord rich precence
g.discord = false
