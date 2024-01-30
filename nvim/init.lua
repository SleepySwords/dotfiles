-- vim.loader.enable()

local g = vim.g
local o = vim.o

local function set_ft_option(ft, option, value)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    group = vim.api.nvim_create_augroup('FtOptions', {}),
    desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
    callback = function()
      vim.opt_local[option] = value
    end
  })
end

-- Vim options setup
set_ft_option("markdown", "spell", true)
set_ft_option("markdown", "linebreak", true)

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
o.omnifunc = "v:lua.vim.lsp.omnifunc"
o.mouse = "a"
-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
o.hidden = true
o.guifont = "Fira code retina:h11" -- ,Hack Nerd Font:11'

o.foldcolumn = "1"
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

o.laststatus = 3
o.mousemodel = "extend"
o.ignorecase = true

-- Formatting
o.shiftwidth = 4

-- This was set to 1 before for some reason, should probably investigate
o.conceallevel = 3

require("keybindings")
require("plugins")

-- Highlights when yannking (y)
vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()", true)

vim.cmd("autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>", true)
-- vim.cmd("autocmd! FileType rust set softtabstop=0", true)

-- Recognize wgsl
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")

-- Global settings

-- Theme settings
-- Good themes: duskfox, onedark, sonokai, tokyonight-night(used for longest time)
g.edge_style = "aura"
g.edge_endable_italic = 1
g.edge_disable_italic_comment = 1
g.sonokai_style = "shusia"
g.sonokai_enable_italic = 1
g.sonokai_disable_italic_comment = 1
g.sonokai_diagnostic_virtual_text = "colour_background"
g.neon_style = "default"
g.neon_italic_keyword = true
g.neon_italic_function = true
g.neon_transparent = true
-- FIX: stop hardcoding colours, add a rgb to hsl and modify defaults.
vim.cmd([[colorscheme catppuccin-mocha]])
g.telescope_theme = require("navigation.telescope").get_telescope_theme()

-- Plugin settings
g.ultest_fail_sign = ""
g.ultest_pass_sign = ""

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
-- vim.cmd [[highlight link TelescopeMatching Type]]
-- Icons become weird when bolded
-- vim.cmd [[highlight TelescopeSelection guifg=#f0a6cc gui=bold]]
