vim.loader.enable()


local o = vim.o
local g = vim.g

-- vim.lsp.set_log_level("debug")
-- require'plenary.profile'.start("profile.log")

-- Vim options setup
o.compatible = false
o.nu = true
o.rnu = true
o.completeopt = "menuone,noinsert,noselect"
o.shortmess = o.shortmess .. "c"
-- o.shiftwidth = 4
-- o.tabstop = 4
o.autoindent = true
o.smartindent = true
o.cmdheight = 1
o.updatetime = 500
o.signcolumn = "yes"
o.clipboard = "unnamed,unnamedplus"
o.showmatch = true
o.termguicolors = true
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.mouse = 'a'
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
o.hidden = true
o.guifont = 'Jetbrains Mono Medium:h11' -- ,Hack Nerd Font:11'

o.foldcolumn = '1'
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

o.laststatus = 3
o.mousemodel = "extend"
o.ignorecase = true


o.conceallevel = 1


-- Highlights when yannking (y)
vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)

vim.cmd("autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>", true)
-- vim.cmd("autocmd! FileType rust set softtabstop=0", true)

-- Recognize wgsl
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")

-- Theme settings
if not g.bootstrap then
	g.edge_style = 'aura'
	g.edge_endable_italic = 1
	g.edge_disable_italic_comment = 1
	g.sonokai_style = 'shusia'
	g.sonokai_enable_italic = 1
	g.sonokai_disable_italic_comment = 1
	g.sonokai_diagnostic_virtual_text = 'colour_background'
	-- g.colors_name = 'duskfox'
	-- cmd[[colorscheme sonokai]]
	-- cmd [[colorscheme tokyonight-night]]
	-- cmd [[colorscheme onedark]]
	vim.cmd [[colorscheme tokyonight-night]]
	-- vim.cmd [[colorscheme duskfox]]
	g.telescope_theme = require("navigation.telescope").get_telescope_theme()
end

-- Plugin settings
g.ultest_fail_sign = ''
g.ultest_pass_sign = ''

-- Neovide
-- g.neovide_fullscreen = true
-- g.neovide_transparency = 0.9

-- g.neovide_floating_blur_amount_x = 2.0
-- g.neovide_floating_blur_amount_y = 2.0
g.neovide_refresh_rate = 250

-- g.neovide_cursor_vfx_mode = "pixiedust"

-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = { 'exact', 'substring', 'fuzzy' }

g.indent_blankline_show_first_indent_level = false

-- vim.cmd [[highlight Cursor guifg=#000000 guibg=#FBC3BC]]
-- vim.cmd [[highlight link TelescopeMatching Type]]
vim.cmd [[highlight! link TelescopeSelection Define]]
-- Icons become weird when bolded
-- vim.cmd [[highlight TelescopeSelection guifg=#f0a6cc gui=bold]]
vim.cmd [[highlight! TelescopeMatching guifg=#f6c177 gui=bold]]
vim.cmd [[highlight! link FloatBorder NormalFloat]]

g.Illuminate_ftblacklist = { 'NvimTree', 'dashboard' }

-- Global settings revolving this config
g.discord = false
g.indicator_ok = ''

-- TODO: hightlight seleted line number
-- TODO: fix glitchy tab in visual mode.
g.neon_style = "default"
g.neon_italic_keyword = true
g.neon_italic_function = true
g.neon_transparent = true


require('plugins')
require('keybindings')

vim.cmd [[highlight InlaySurround guifg=#2d2b46]]
vim.cmd [[highlight InlayText guibg=#2d2b46 guifg=#8a87b6]]

vim.api.nvim_set_hl(0, 'Folded', {})
