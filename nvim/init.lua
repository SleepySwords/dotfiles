vim.loader.enable()

-- Bootstrapping Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("keybindings")
require("lazy").setup({{import = "plugins"}, {import = "plugins.editing"}})
require('options')

local g = vim.g

-- Global settings

-- Theme settings
-- Good themes: duskfox, onedark, sonokai, tokyonight-night(used for longest time)
g.edge_style = "aura"
g.edge_endable_italic = 1
g.edge_disable_italic_comment = 1
g.sonokai_style = "shusia"
g.sonokai_enable_italic = 1
g.sonokai_disable_italic_comment = 1
g.sonokai_diagnostic_virtual_text = "colour_background" g.neon_style = "default"
g.neon_italic_keyword = true
g.neon_italic_function = true
g.neon_transparent = true

vim.cmd([[colorscheme catppuccin-mocha]])
g.telescope_theme = require("navigation.telescope").get_telescope_theme()

-- Plugin settings
g.ultest_fail_sign = ""
g.ultest_pass_sign = ""

if vim.g.neovide then
	vim.cmd([[colorscheme catppuccin-latte]])
end
-- Neovide
-- g.neovide_fullscreen = true
-- g.neovide_transparency = 0.9

g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0
-- g.neovide_cursor_vfx_mode = "pixiedust"
g.neovide_refresh_rate = 250
g.neovide_window_blurred = true

-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = { "exact", "substring", "fuzzy" }

g.indent_blankline_show_first_indent_level = false
g.Illuminate_ftblacklist = { "NvimTree", "dashboard" }

g.discord = false
g.indicator_ok = ""

-- -- Highlights when yannking (y)
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern = "*",
--   command = "silent! lua require'vim.highlight'.on_yank()"
-- })

-- vim.cmd("autocmd FileType fzf tnoremap <buffer> <esc> <c-c>", true)

-- -- Recognize wgsl
-- vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")

vim.api.nvim_set_hl(0, "InlaySurround", { fg = "#2d2b46" })
vim.api.nvim_set_hl(0, "InlayText", { bg = "#2d2b46", fg = "#171724" })
vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "#232338" })

vim.api.nvim_set_hl(0, "Folded", {})
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "UfoFoldedBg", {})

vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "Define" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "TelescopeMatching", { bold = true, fg = "#f6c177" })

-- vim.cmd [[highlight Cursor guifg=#000000 guibg=#FBC3BC]]
