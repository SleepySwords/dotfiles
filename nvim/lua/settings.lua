require('vim._core.ui2').enable({})

-- Vim options
local o = vim.opt

local group = vim.api.nvim_create_augroup('FtOptions', {})

local function set_ft_option(ft, option, value)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = group,
        desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
        callback = function()
            vim.opt_local[option] = value
        end,
    })
end

-- Vim options setup
set_ft_option('markdown', 'spell', true)
set_ft_option('markdown', 'linebreak', true)
set_ft_option('markdown', 'textwidth', 80)

set_ft_option('typst', 'spell', true)
set_ft_option('typst', 'linebreak', true)

-- Ruler settings
o.nu = true
o.rnu = true
o.hidden = true
o.ignorecase = true
o.showmatch = true
o.signcolumn = 'yes'

-- Fold symbols
o.foldcolumn = '1'
o.fillchars = {
    eob = ' ',
    fold = ' ',
    foldopen = '',
    foldsep = ' ',
    foldclose = '',
    diff = '╱'
}
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- Omni completion settings
o.completeopt = 'menuone,noinsert,noselect'
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
table.insert(o.shortmess, 'c')
o.updatetime = 500
-- o.clipboard = 'unnamedplus'

-- Terminal settings
o.termguicolors = true
o.guifont = 'CommitMono:h11'

-- Show non-vis characters
o.list = true
o.listchars = { tab = '  ', trail = ' ', extends = '>', precedes = '<', nbsp = '+' }

o.conceallevel = 3

-- Mouse
o.mouse = 'a'
o.mousemodel = 'extend'

-- Status bar
o.laststatus = 3
o.showtabline = 3
o.cmdheight = 1

-- Spacing
o.scrolloff = 1
o.sidescrolloff = 2

-- Formatting
o.shiftwidth = 4
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.autoindent = true
o.smartindent = true

-- Sessions
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
o.shada = "'1000,f0"

local g = vim.g

-- Global settings
local themes = { 'catppuccin-mocha',
    'carbonfox',
    'catppuccin-latte',
    'industry',
    'tokyonight-moon',
    'edge',
    'duskfox' }
vim.cmd(([[colorscheme %s]]):format(themes[2]))

if vim.g.neovide then
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_padding_top = 5
    vim.g.neovide_padding_bottom = 5

    vim.o.winblend = 30
end
g.indicator_ok = ''
