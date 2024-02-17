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
o.autoindent = true
o.smartindent = true
o.cmdheight = 1
o.updatetime = 500
o.signcolumn = "yes"
o.clipboard = "unnamed,unnamedplus"
o.showmatch = true
o.showtabline = 3
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
o.tabstop = 4

-- This was set to 1 before for some reason, should probably investigate
o.conceallevel = 3
