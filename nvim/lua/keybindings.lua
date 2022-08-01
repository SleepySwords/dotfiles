local g = vim.g

local map_key = vim.api.nvim_set_keymap
local function map(modes, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	if type(modes) == 'string' then modes = { modes } end
	for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end

local function map_desc(modes, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	opts.desc = desc
	if type(modes) == 'string' then modes = { modes } end
	for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end

g.mapleader = [[z]]
g.maplocalleader = [[\]]

-- Enable completion triggered by <c-x><c-o>
-- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

-- TODO: Really need to check if these keybindings override some other default bindings.
map_desc({ 'n' }, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', "LSP Declaration", opts)
map_desc({ 'n' }, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', "LSP Definition", opts)
map_desc({ 'n' }, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', "LSP Implementation", opts)
map_desc({ 'n' }, 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', "LSP Rename", opts)
map_desc({ 'n' }, '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', "LSP Signature Help", opts)
map_desc({ 'n' }, '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "LSP Add Workspace", opts)
map_desc({ 'n' }, '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "LSP Remove Workspace", opts)
map_desc({ 'n' }, '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', "LSP List Workspaces", opts)
map_desc({ 'n' }, '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', "LSP Type Definition", opts)
map_desc({ 'n' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', "LSP Code Action", opts)
map_desc({ 'n' }, 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', "LSP References", opts)
map_desc({ 'n' }, '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', "LSP Open Diagnostics", opts)
map_desc({ 'n' }, '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', "LSP Previous Diagnostic", opts)
map_desc({ 'n' }, ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', "LSP Next Diagnostic", opts)
map_desc({ 'n' }, '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', "LSP Set Loclist", opts)
map_desc({ 'n' }, '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', "LSP Format", opts)
map_desc({ 'n' }, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', "LSP Hover")

-- map('i', '<C-p>', '<Plug>(completion_trigger)', { silent=true })

-- LSP Saga (Until LSP Sage is fixed)
-- map('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
-- map('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
-- map('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
-- map('n', '<leader>dg', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)

-- map('n', '<leader>d', "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", opts) -- or open_float_terminal('lazygit')<CR>
-- map('t', '<leader>d', "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", opts)

map('n', '<leader>gg', '<cmd>LazyGit<CR>', opts)

-- map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
-- map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
-- map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

-- Bindings for Telescope and Nvim Tree
map_desc({ 'n' }, '<leader>ff', '<cmd>lua require("telescope.builtin").find_files(vim.g.telescope_theme)<CR>', "Open File Picker", { noremap = true })
map_desc({ 'n' }, '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep(vim.g.telescope_theme)<cr>', "Open Live Grep", { noremap = true })
map_desc('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers(vim.g.telescope_theme)<cr>', "Open Buffer Picker", { noremap = true })
map_desc({ 'n' }, '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags(vim.g.telescope_theme)<cr>', "Open Help Tags", { noremap = true })
map_desc({ 'n' }, '<leader>fl', '<cmd>lua require("telescope.builtin").git_files(vim.g.telescope_theme)<cr>', "Open Git Files", { noremap = true })
map_desc({ 'n' }, '<leader>tt', '<cmd>NvimTreeToggle<CR>', "Open File Tree", { noremap = true })
map_desc({ 'n' }, '<leader>tr', '<cmd>NvimTreeRefresh<CR>', "Refresh File Tree", { noremap = true })
map_desc({ 'n' }, '<leader>tn', '<cmd>NvimTreeFindFile<CR>', "Find Current File In Tree", { noremap = true })

map_desc({ 'n' }, '<leader>ft', '<cmd>lua require("neotest").summary.open()<CR>', "Open summary test window", { noremap = true })

map_desc({ 'n' }, '<leader>fn', '<cmd>HopWord<CR>', "Hop Word", { noremap = true} )

-- Keybind for https://vi.stackexchange.com/questions/24502/deleting-without-copying-to-clipboard-in-windows
-- https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
map_desc({ 'n' }, '\\', '\'_', "Blackhole Register", { noremap = true })


-- Moving chunks of code using tab and shift tab in visual mode
map_desc({ 'v' }, '<Tab>', '>gv', "Visual-Mode Indent Code", { noremap = true })
map_desc({ 'v' }, '<S-Tab>', '<gv', "Visual-Mode Outdent Code", { noremap = true })

-- map({ 'v' }, '>', '>gv', { noremap=true })
-- map({ 'v' }, '<', '<gv', { noremap=true })

-- map({ 'n' }, '>', '>>', { noremap=true })
-- map({ 'n' }, '<', '<<', { noremap=true })

-- Buffer handling
-- map_desc({ 'n' }, 'L', '<cmd>let &number=1-&number<CR>', "Change Between Relative")
map_desc({ 'n' }, 'L', '<cmd>if &rnu | set nornu | else | set rnu | endif<CR>', "Change Between Relative")
map_desc({ 'n' }, '<leader>n', '<cmd>bnext<CR>', "Goto Next Buffer")
map_desc({ 'n' }, '<leader>p', '<cmd>bprevious<CR>', "Goto Prev Buffer")
map_desc({ 'n' }, '<leader>bq', '<cmd>BufDel<CR>', "Delete The Current Buffer")
map({ 'n' }, '<leader>bl', '<cmd>ls<CR>')
map({ 'n' }, '<leader>0', '<cmd>set invnumber<CR>')
-- http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit
-- Tooo lazy to port
-- vim.cmd("cnoreabbrev <expr> q getcmdtype() == ':' && (getcmdline() == 'q' && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1) ? 'BufDel' : 'q'")

-- Debugging
map({ 'n' }, '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
map({ 'n' }, '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
map({ 'n' }, '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
map({ 'n' }, '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
map({ 'n' }, '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

map({ 'n' }, '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
map({ 'n' }, '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
map({ 'v' }, '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

map({ 'n' }, '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
map({ 'n' }, '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

map({ 'n' }, '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map({ 'n' }, '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map({ 'n' }, '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
map({ 'n' }, '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

map({ 'n' }, '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')

-- telescope-dap
map({ 'n' }, '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands(vim.g.telescope_theme)<CR>')
map({ 'n' }, '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations(vim.g.telescope_theme)<CR>')
map({ 'n' }, '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints(vim.g.telescope_theme)<CR>')
map({ 'n' }, '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables(vim.g.telescope_theme)<CR>')
map({ 'n' }, '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames(vim.g.telescope_theme)<CR>')

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
-- map({ 't' }, '<esc>', [[<C-\><C-n>]], { noremap = true })
map({ 't' }, '<C-h>', [[<C-\><C-n><C-W>h]], { noremap = true })
map({ 't' }, '<C-j>', [[<C-\><C-n><C-W>j]], { noremap = true })
map({ 't' }, '<C-k>', [[<C-\><C-n><C-W>k]], { noremap = true })
map({ 't' }, '<C-l>', [[<C-\><C-n><C-W>l]], { noremap = true })
map({ 'n' }, '<leader>fo', '<cmd>lua _floatwindow_toggle()<CR>', { noremap = true })
map({ 'n' }, '<leader>fp', '<cmd>ToggleTerm direction=float<CR>', { noremap = true })

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

vim.cmd[[
augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> \[\[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> \]\] <Plug>(omnisharp_navigate_down)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

]]
