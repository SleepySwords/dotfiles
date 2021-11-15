local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require 'config.utils'
local opt = utils.opt
local autocmd = utils.autocmd
local map = utils.map

require('plugins')
require('completion')
require('ui')
require('config.navigation')
require('config.miscellaneous')
require('keybindings')
require('dbg')

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
opt('updatetime', 50)
opt('signcolumn', "yes")
opt('clipboard', "unnamed,unnamedplus")
opt('showmatch',  true)
opt('termguicolors', true)
opt('omnifunc', 'v:lua.vim.lsp.omnifunc')
opt('mouse', 'a')
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
opt('hidden', true)
opt('guifont', 'Hack Nerd Font:l')

autocmd("highlight_yank", "TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)

-- Theme settings
g.edge_style = 'aura'
g.edge_endable_italic = 1
g.edge_disable_italic_comment = 1
-- g.colors_name = 'edge'
g.sonokai_style = 'shusia'
g.sonokai_enable_italic = 1
g.sonokai_disable_italic_comment = 1
g.colors_name = 'sonokai'

-- Plugin settings
-- g.rustfmt_autosave = 1
g.ultest_icons = false

-- Neovide
-- g.neovide_fullscreen = true
