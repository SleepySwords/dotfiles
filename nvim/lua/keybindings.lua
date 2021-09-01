local g = vim.g
local utils = require 'config.utils'
local map = utils.map

g.mapleader = [[z]]
g.maplocalleader = [[\]]

-- Enable completion triggered by <c-x><c-o>
-- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

map('i', '<C-p>', '<Plug>(completion_trigger)', { silent=true })

-- Auto completion (compe)
map('i', '<C-Space>', 'compe#complete()', { silent=true, expr=true })

-- LSP Saga
map('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
map('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
map('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
map('n', '<leader>dg', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)

map('n', '<leader>d', "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", opts) -- or open_float_terminal('lazygit')<CR>
map('t', '<leader>d', "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", opts)

map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)


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
map('n', 'L', ':let &number=1-&number<CR>')
map('n', '<leader>l', '<cmd>bnext<CR>')
map('n', '<C-h>', '<cmd>bprevious<CR>')
map('n', '<leader>bq', '<cmd>bp <BAR> bd #<CR>')
map('n', '<leader>bl', '<cmd>ls<CR>')
map('n', '<leader>0', '<cmd>set invnumber<CR>')
-- http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit
-- Tooo lazy to port
vim.cmd("cnoreabbrev <expr> q getcmdtype() == ':' && (getcmdline() == 'q' && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1) ? 'bd' : 'q'")


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


local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
