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

o.compatible = false
o.nu = true
o.rnu = true
o.completeopt = 'menuone,noinsert,noselect'
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
table.insert(o.shortmess, 'c')
o.signcolumn = 'yes'
o.updatetime = 500
o.clipboard = 'unnamedplus'

-- https://supo.updatetimeeruser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file life saver
o.hidden = true
o.ignorecase = true
o.showmatch = true

o.termguicolors = true
o.guifont = 'Jetbrains Mono:h11'
-- o.guifont = 'Firacode nerd font:h11'

o.foldcolumn = '1'
o.fillchars =
    { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '', diff = '╱' }
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

o.mouse = 'a'
o.mousemodel = 'extend'

o.laststatus = 3
o.showtabline = 3

o.conceallevel = 3
o.cmdheight = 1
o.scrolloff = 1
o.sidescrolloff = 2

-- Formatting
o.shiftwidth = 4
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.autoindent = true
o.smartindent = true

o.listchars = { tab = '  ', trail = ' ', extends = '>', precedes = '<', nbsp = '+' }
o.list = true
o.showcmdloc = 'statusline'
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

o.shada = "'1000,f0"

local g = vim.g

-- Global settings

-- Theme settings
-- Good themes: duskfox, onedark, sonokai, tokyonight-night(used for longest time), eva01

-- vim.cmd([[colorscheme catppuccin-mocha]])
-- vim.cmd([[colorscheme carbonfox]])
vim.cmd([[colorscheme dawnfox]])

if vim.g.neovide then
    -- vim.cmd([[colorscheme carbonfox]])
    -- vim.cmd([[colorscheme catppuccin-latte]])
    -- vim.cmd([[colorscheme industry]])
    -- vim.cmd([[colorscheme tokyonight-moon]])
    -- vim.cmd([[colorscheme edge]])
    -- vim.cmd([[colorscheme duskfox]])

    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_padding_top = 5
    vim.g.neovide_padding_bottom = 5

    vim.o.winblend = 30
else
    -- vim.cmd([[colorscheme catppuccin-latte]])
    -- vim.cmd([[colorscheme flow]])
    -- vim.cmd "colorscheme nightfox"
end

g.discord = false
g.indicator_ok = ''
