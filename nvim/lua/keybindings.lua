local g = vim.g
local utils = require 'config.utils'
local map = utils.map

g.mapleader = [[z]]
g.maplocalleader = [[\]]

-- Enable completion triggered by <c-x><c-o>
-- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

map('i', '<C-p>', '<Plug>(completion_trigger)', { silent=true })

-- LSP Saga (Until LSP Sage is fixed)
-- map('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
-- map('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
-- map('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
-- map('n', '<leader>dg', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)

-- map('n', '<leader>d', "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", opts) -- or open_float_terminal('lazygit')<CR>
-- map('t', '<leader>d', "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", opts)

-- map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
-- map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
-- map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

-- Bindings for Telescope and Nvim Tree
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap=true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap=true })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap=true })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap=true })
map('n', '<leader>fl', '<cmd>Telescope git_files<cr>', { noremap=true })
map('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', { noremap=true })
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>', { noremap=true })
map('n', '<leader>tn', '<cmd>NvimTreeFindFile<CR>', { noremap=true })

-- Keybind for https://vi.stackexchange.com/questions/24502/deleting-without-copying-to-clipboard-in-windows
-- https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
map('n', '\\', '\'_', { noremap=true })


-- Moving chunks of code using tab and shift tab in visual mode
map('v', '<Tab>', '>gv', { noremap=true })
map('v', '<S-Tab>', '<gv', { noremap=true })


-- Buffer handling
map('n', 'L', '<cmd>let &number=1-&number<CR>')
map('n', '<leader>n', '<cmd>bnext<CR>')
map('n', '<leader>p', '<cmd>bprevious<CR>')
map('n', '<leader>bq', '<cmd>BufDel<CR>')
map('n', '<leader>bl', '<cmd>ls<CR>')
map('n', '<leader>0', '<cmd>set invnumber<CR>')
-- http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit
-- Tooo lazy to port
-- vim.cmd("cnoreabbrev <expr> q getcmdtype() == ':' && (getcmdline() == 'q' && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1) ? 'BufDel' : 'q'")

-- Debugging
map('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

map('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
map('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
map('v', '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

map('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

map('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')

-- telescope-dap
map('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
map('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
map('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
map('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

-- Snippets

-- map('i', '<expr> <C-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'")
-- map('s', '<expr> <C-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'")

-- -- Expand or jump
-- map('i', '<expr> <C-l>', "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'")
-- map('s', '<expr> <C-l>', "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'")

-- -- Jump forward or backward
-- map('i', '<expr> <Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
-- map('s', '<expr> <Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
-- map('i', '<expr> <S-Tab>', "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
-- map('s', '<expr> <S-Tab>', "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")

-- -- Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
-- -- See https://github.com/hrsh7th/vim-vsnip/pull/50
-- map('n', 's', '<Plug>(vsnip-select-text)')
-- map('x', 's', '<Plug>(vsnip-select-text)')
-- map('n', 'S', '<Plug>(vsnip-cut-text)')
-- map('x', 'S', '<Plug>(vsnip-cut-text)')

-- Terminal
map('t', '<esc>', [[<C-\><C-n>]], { noremap = true })
map('t', '<C-h>', [[<C-\><C-n><C-W>h]], { noremap = true })
map('t', '<C-j>', [[<C-\><C-n><C-W>j]], { noremap = true })
map('t', '<C-k>', [[<C-\><C-n><C-W>k]], { noremap = true })
map('t', '<C-l>', [[<C-\><C-n><C-W>l]], { noremap = true })
map('n', '<leader>fo', '<cmd>lua _floatwindow_toggle()<CR>', { noremap = true })
map('n', '<leader>fp', '<cmd>ToggleTerm<CR>', { noremap = true })

-- Need to convert to lua
vim.cmd [[ 
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
]]
