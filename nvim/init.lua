local utils = require 'config.utils'
local opt = utils.opt
local autocmd = utils.autocmd
local o = vim.o
local g = vim.g
local cmd = vim.cmd

-- local g = vim.g
-- local cmd = vim.cmd
-- local o, wo, bo = vim.o, vim.wo, vim.bo
-- local utils = require 'config.utils'
-- local opt = utils.opt
-- local autocmd = utils.autocmd
-- local map = utils.map
--
require('profiler')

require('plugins')
require('completion.lsp')
require('ui.ui')
require('config.navigation')
require('config.miscellaneous')
require('keybindings')
require('dbg.dbg')

-- Vim options setup
opt('compatible', false)
opt('nu', true)
opt('rnu', true)
opt('completeopt', "menuone,noinsert,noselect")
opt('shortmess', o.shortmess .. "c")
-- opt('expandtab', true)
-- opt('tabstop', 4)
opt('shiftwidth', 4)
opt('autoindent', true)
opt('smartindent', true)
opt('cmdheight', 2)
opt('updatetime', 500)
opt('signcolumn', "yes")
opt('clipboard', "unnamed,unnamedplus")
opt('showmatch',  true)
opt('termguicolors', true)
opt('omnifunc', 'v:lua.vim.lsp.omnifunc')
opt('mouse', 'a')
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
opt('hidden', true)
opt('termguicolors', true)
-- opt('guifont', 'Hack Nerd Font:l')
-- opt('foldmethod', 'expr')
-- opt('foldexpr', 'nvim_treesitter#foldexpr()')
opt('guifont', 'Jetbrains Mono,Hack Nerd Font:l14')

-- autocmd("highlight_yank", "TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)
vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)



-- Theme settings
g.edge_style = 'aura'
g.edge_endable_italic = 1
g.edge_disable_italic_comment = 1
-- g.colors_name = 'edge'
g.sonokai_style = 'shusia'
g.sonokai_enable_italic = 1
g.sonokai_disable_italic_comment = 1
g.sonokai_diagnostic_virtual_text = 'colour_background'
g.colors_name = 'sonokai'
cmd[[colorscheme sonokai]]
-- g.colors_name = 'tokyonight'
g.telescope_theme = require("ui.telescope").get_theme()
-- g.telescope_theme = require("telescope.themes").get_ivy()

-- Plugin settings
g.ultest_fail_sign = ''
g.ultest_pass_sign = ''

-- Neovide
g.neovide_fullscreen = true

-- Keybinding settings

-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.ale_linters = {cs = 'OmniSharp'}
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = {'exact', 'substring', 'fuzzy'}
-- g.discord = False
