local o = vim.o
local g = vim.g
local cmd = vim.cmd

-- require'plenary.profile'.start("profile.log")

vim.opt.runtimepath:append("~/Stuff/Computer_Science/lua/neotest-rust")

require('impatient').enable_profile()

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
o.showmatch = true
o.termguicolors = true
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.mouse = 'a'
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
o.hidden = true
o.termguicolors = true
o.guifont = 'Jetbrains Mono,Hack Nerd Font:14'

o.laststatus = 3

-- opt('guifont', 'Hack Nerd Font:l')
-- opt('foldmethod', 'expr')
-- opt('foldexpr', 'nvim_treesitter#foldexpr()')
-- opt('expandtab', true)
-- opt('tabstop', 4)

-- g.firenvim_config = {
--     localSettings = {}
-- }

-- local fc = g.firenvim_config['localSettings']
-- fc['.*'] = {
--     selector = 'textarea',
--     takeover = 'once',
-- }
-- fc['https?://*\\.google\\.com/*'] = { takeover = 'never', priority = 1 }
-- Highlights when yannking (y)
cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)

cmd("autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>", true)

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
	g.tokyonight_style = "night"
	-- cmd[[colorscheme sonokai]]
	-- cmd [[colorscheme duskfox]]
	-- cmd [[colorscheme onedark]]
	cmd [[colorscheme tokyonight]]
	g.telescope_theme = require("ui.telescope").get_theme()
end
-- g.colors_name = 'tokyonight'
-- g.colors_name = 'edge'
-- g.telescope_theme = require("telescope.themes").get_ivy()

-- vim.fn.sign_define("Cursor", { text = icon, texthl = hl, numhl = hl })


-- Plugin settings
g.ultest_fail_sign = ''
g.ultest_pass_sign = ''

-- Neovide
-- g.neovide_fullscreen = true
g.neovide_cursor_vfx_mode = "pixiedust"
-- g.neovide_cursor_vfx_particle_lifetime=10
-- g.neovide_cursor_vfx_particle_density=1000.0


-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.ale_linters = { cs = 'OmniSharp' }
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = { 'exact', 'substring', 'fuzzy' }

vim.cmd[[highlight Cursor guifg=#000000 guibg=#FBC3BC]]

g.Illuminate_ftblacklist = { 'NvimTree', 'dashboard' }

-- Global settings revolving this config
g.discord = false
g.indicator_ok = ''

-- TODO: hightlight seleted line number
-- TODO: fix glitchy tab in visual mode.
vim.g.neon_style = "default"
vim.g.neon_italic_keyword = true
vim.g.neon_italic_function = true
vim.g.neon_transparent = true
-- vim.g.tokyonight_transparent = true

-- require'plenary.profile'.stop()

-- _G.gps_location = function()
--   local gps = require "nvim-gps"
--   return gps.is_available() and gps.get_location() or ""
-- end
-- vim.opt.winbar = "%{%v:lua.gps_location()%}"
