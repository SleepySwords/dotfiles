local g = vim.g

local map = vim.keymap.set

local default_opts = { noremap = true, silent = true }

local function default(desc)
    return { desc = desc, noremap = true, silent = true }
end

g.mapleader = [[ ]]
g.maplocalleader = [[\]]

-- TODO: Really need to check if these keybindings override some other default bindings.
map({ 'n' }, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default('LSP Definition'))
map({ 'n' }, 'grd', '<cmd>lua vim.lsp.buf.declaration()<CR>', default('LSP Declaration'))
map({ 'n' }, 'gri', '<cmd>lua vim.lsp.buf.implementation()<CR>', default('LSP Implementation'))
map({ 'n' }, 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', default('LSP Rename'))
map({ 'n' }, 'grt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', default('LSP Rename'))
map({ 'n' }, 'grr', function()
    vim.lsp.buf.references()
end, default('LSP references in quick fix list')) -- lua vim.lsp.buf.references()
map(
    { 'n' },
    'grt',
    '<cmd>Trouble lsp_references toggle follow=true focus=true auto_refresh=false<CR>',
    default('LSP References')
)

map({ 'n' }, '<leader>co', function()
    if vim.iter(vim.api.nvim_tabpage_list_wins(0)):any(function(w) return vim.fn.win_gettype(w) == "quickfix" end) then
        vim.cmd("ccl")
    else
        vim.cmd("copen")
    end
end, default('Toggle quick fix list')) -- lua vim.lsp.buf.references()
map({ 'n' }, '<C-q>', function()
    if vim.iter(vim.api.nvim_tabpage_list_wins(0)):any(function(w) return vim.fn.win_gettype(w) == "quickfix" end) then
        vim.cmd("ccl")
    else
        vim.cmd("copen")
    end
end, default('Toggle quick fix list')) -- lua vim.lsp.buf.references()
map(
    { 'n' },
    '<leader>cc',
    '<cmd>caddexpr expand("%") .. ":" .. line(".") ..  ":" .. col(".") .. ":" .. getline(".")<CR>',
    { desc = 'Add current pos to quickfix' }
)

map(
    { 'n' },
    '<leader>k',
    '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    default('LSP Signature Help')
)
map(
    { 'n' },
    '<leader>cwa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    default('LSP Add Workspace')
)
map(
    { 'n' },
    '<leader>cwr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    default('LSP Remove Workspace')
)
map(
    { 'n' },
    '<leader>cwl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    default('LSP List Workspaces')
)

map({ 'n' }, '<leader>w', function()
    require('which-key').show({
        keys = '<c-w>',
        loop = true, -- this will keep the popup open until you hit <esc>
    })
end, default('Which-key window'))

map({ 'n' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', default('LSP Code Action'))
map(
    { 'n' },
    '<leader>ci',
    '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
    default('LSP Code Action')
)
map({ 'n' }, '<leader>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', default('LSP Codelens run'))
map(
    { 'n' },
    '<leader>cL',
    '<cmd>lua vim.lsp.codelens.refresh()<CR>',
    default('LSP Code lens refresh')
)
map(
    { 'n' },
    '<space>e',
    '<cmd>lua vim.diagnostic.open_float()<CR>',
    default('LSP Open Diagnostics float')
)
map({ 'n' }, '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', default('LSP Previous Diagnostic'))
map({ 'n' }, ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', default('LSP Next Diagnostic'))
map({ 'n' }, '<space>dqf', '<cmd>lua vim.diagnostic.setqflist()<CR>', default('LSP Set Loclist'))
map(
    { 'n' },
    '<space>cf',
    '<cmd>lua vim.lsp.buf.format { async = true, filter = function(client) return client.name ~= "tsserver" end }<CR>',
    default('LSP Format')
)
map({ 'n' }, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default('LSP Hover'))

map({ 'n' }, '<leader>xx', '<cmd>Trouble toggle<CR>', default('Trouble Toggle'))
map(
    { 'n' },
    '<leader>xd',
    '<cmd>Trouble workspace_diagnostics toggle<CR>',
    default('Trouble workspace diagnostics')
)
map(
    { 'n' },
    '<leader>xe',
    '<cmd>Trouble diagnostics toggle<CR>',
    default('Trouble document diagnostics')
)
map({ 'n' }, '<leader>xq', '<cmd>Trouble quickfix toggle<CR>', default('Trouble quickfix'))
map({ 'n' }, '<leader>xt', '<cmd>TodoTrouble<CR>', default('Troule todo'))
map(
    { 'n' },
    '<leader>xn',
    '<cmd>lua require("trouble").next({skip_groups = true, jump = true});<CR>',
    default('Trouble next')
)
map(
    { 'n' },
    '<leader>xp',
    '<cmd>lua require("trouble").previous({skip_groups = true, jump = true});<CR>',
    default('Trouble previous')
)

-- Bindings for Telescope and Nvim Tree
map(
    { 'n' },
    '<leader>f',
    function()
        local ok = pcall(require("telescope.builtin").git_files)

        if not ok then
            require("telescope.builtin").find_files()
        end
    end,
    default('Open File Picker')
)
map(
    { 'n' },
    '<leader>F',
    function()
        require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true })
    end,
    default('Open File Picker')
)
map(
    { 'n' },
    '<leader>ag',
    '<cmd>lua require("telescope.builtin").live_grep()<cr>',
    default('Open Live Grep')
)
map(
    'n',
    '<leader>b',
    '<cmd>lua require("telescope.builtin").buffers()<cr>',
    default('Open Buffer Picker')
)
map(
    { 'n' },
    '<leader>ht',
    '<cmd>lua require("telescope.builtin").help_tags()<cr>',
    default('Open Help Tags')
)
map(
    { 'n' },
    '<leader>hh',
    '<cmd>lua require("telescope.builtin").highlights()<cr>',
    default('Open Help Tags')
)
map(
    { 'n' },
    '<leader>S',
    '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>',
    default('Open document symbols')
)
map(
    { 'n' },
    '<leader>D',
    '<cmd>lua require("telescope.builtin").diagnostics()<cr>',
    default('Open telescope diagnostics')
)
map(
    { 'n' },
    '<leader>hr',
    '<cmd>lua require("telescope.builtin").lsp_references()<cr>',
    default('Open telescope references')
)
map(
    { 'n' },
    '<leader>s',
    '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols({path_display = "hidden" })<cr>',
    default('Open workspace symbols')
)
map(
    { 'n' },
    '<leader><C-s>',
    '<cmd>lua require("telescope.builtin").lsp_workspace_symbols({path_display = "hidden" })<cr>',
    default('Open workspace symbols')
)
map({ 'n' }, '<leader>u', '<cmd>UndotreeToggle<cr>', default('Undo tree'))

local command =
[[<cmd>lua require("telescope.builtin").colorscheme({enable_preview = true, layout_config = { horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8, }, vertical = { mirror = false, }, width = 0.5, height = 0.5, preview_cutoff = 120, }, })<cr>]]
map({ 'n' }, '<leader>hc', command, default('Open Colour Scheme'))

map({ 'n' }, '<leader>t', '<cmd>NvimTreeToggle<CR>', default('Open File Tree'))
map({ 'n' }, '<leader>ar', '<cmd>NvimTreeRefresh<CR>', default('Refresh File Tree'))
map({ 'n' }, '<leader>an', '<cmd>NvimTreeFindFile<CR>', default('Find Current File In Tree'))
map({ 'n' }, '<leader>o', '<cmd>Oil<CR>', default('Open File Tree'))

map({ 'n' }, '<leader>cts', '<cmd>Neotest summary<CR>', default('Open summary test window'))
map({ 'n' }, '<leader>cto', '<cmd>Neotest output<CR>', default('Open output test window'))
map(
    { 'n' },
    '<leader>ctd',
    '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
    default('Run test while attaching debug')
)
map(
    { 'n' },
    '<leader>ctR',
    '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>',
    default('Run all tests')
)
map(
    { 'n' },
    '<leader>ctr',
    '<cmd>lua require("neotest").run.run()<CR>',
    default('Run current test')
)

map({ 'n' }, '<leader>j', '<cmd>HopWord<CR>', default('hop word'))

-- Keybind for https://vi.stackexchange.com/questions/24502/deleting-without-copying-to-clipboard-in-windows
-- https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
map({ 'n', 'v' }, '\\', '"_', { desc = 'Blackhole Register', noremap = true })

-- Moving chunks of code using tab and shift tab in visual mode
map({ 'v' }, '<Tab>', '>gv', { desc = 'Visual-Mode Indent Code', noremap = true })
map({ 'v' }, '<S-Tab>', '<gv', { desc = 'Visual-Mode Outdent Code', noremap = true })

map({ 'v' }, '>', '>gv', { noremap = true })
map({ 'v' }, '<', '<gv', { noremap = true })

-- map({ 'n' }, '>', '>>', opts)
-- map({ 'n' }, '<', '<<', { noremap = true })

-- Setting change
map(
    { 'n' },
    '<leader>L',
    '<cmd>if &rnu | set nornu | else | set rnu | endif<CR>',
    default('Change between relative and absolute line numbers')
)
map(
    { 'n' },
    '<leader>W',
    '<cmd>if &wrap | set nowrap | else | set wrap | endif<CR>',
    default('Change between relative and absolute line numbers')
)
map(
    { 'n', 'v' },
    '<leader>V',
    function()
        if vim.o.virtualedit == "none" then
            vim.o.virtualedit = "all"
        else
            vim.o.virtualedit = "none"
        end
    end,
    default('Change between virtual edit and no virtual edit')
)
map(
    { 'v' },
    '<leader>v',
    "<cmd>'<,'>VBox<CR>",
    default('Change between relative and absolute line numbers')
)
map({ 'n' }, '<leader>0', '<cmd>set invnumber<CR>', default('Set current line number to 0 or not'))
map({ 'n' }, '<leader>ll', '<cmd>ls<CR>', default('Print ls'))

-- Buffer handling
map({ 'n' }, '<leader>n', '<cmd>bnext<CR>', default('Next buffer'))
map({ 'n' }, '<leader>p', '<cmd>bprevious<CR>', default('Previous buffer'))
map({ 'n' }, '<leader>q', '<cmd>BufDel<CR>', default('Delete buffer'))
map({ 'n' }, '<leader>Q', '<cmd>BufDelOthers<CR>', default('Delete all other buffers'))

-- Debugging
map({ 'n' }, '<leader>dc', '<cmd>lua require"dap".continue()<CR>')
map({ 'n' }, '<leader>dn', '<cmd>lua require"dap".step_over()<CR>')
map({ 'n' }, '<leader>di', '<cmd>lua require"dap".step_into()<CR>')
map({ 'n' }, '<leader>do', '<cmd>lua require"dap".step_out()<CR>')
map({ 'n' }, '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
map({ 'n' }, '<leader>dh', '<cmd>lua require"dapui".eval()<CR>')
map(
    { 'n' },
    '<leader>dsbr',
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
)
map(
    { 'n' },
    '<leader>dsbm',
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
)
map({ 'n' }, '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
map({ 'n' }, '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

map({ 'n' }, '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')

-- Debugger Info
map(
    { 'n' },
    '<leader>dtc',
    '<cmd>lua require"telescope".extensions.dap.commands()<CR>'
)
map(
    { 'n' },
    '<leader>dto',
    '<cmd>lua require"telescope".extensions.dap.configurations()<CR>'
)
map(
    { 'n' },
    '<leader>dlb',
    '<cmd>lua require"telescope".extensions.dap.list_breakpoints()<CR>'
)
map(
    { 'n' },
    '<leader>dv',
    '<cmd>lua require"telescope".extensions.dap.variables()<CR>'
)
map(
    { 'n' },
    '<leader>df',
    '<cmd>lua require"telescope".extensions.dap.frames()<CR>'
)
map(
    { 'n' },
    '<leader>ds',
    '<cmd>lua require("dapui").float_element("scopes", { position = "center", enter = true, height = 40, width = 150 })<CR>'
)

-- Terminal
map({ 't' }, '<C-\\>', [[<C-\><C-n>]], { noremap = true })

map({ 'n' }, '<leader>Tn', '<cmd>tab split<cr>')

-- Be able to move chunks of code
-- map({ 'n' }, '<C-j>', '<cmd>:m .+1<CR>==', default_opts)
-- map({ 'n' }, '<C-k>', '<cmd>:m .-2<CR>==', default_opts)
-- map({ 'v' }, '<C-j>', ":move'>+<CR>gv=gv", default_opts)
-- map({ 'v' }, '<C-k>', ':move-2<CR>gv=gv', default_opts)

-- TODO: decide on one for quick fix
map({ 'n' }, ']q', ':cn<CR>', default_opts)
map({ 'n' }, '[q', ':cp<CR>', default_opts)

-- map({ 'n' }, '<C-n>', ':cn<CR>', opts)
-- map({ 'n' }, '<C-p>', ':cp<CR>', opts)

map({ 'n' }, '<C-n>', function()
    if require('trouble').is_open({}) then
        require('trouble').next({ jump = true })
    else
        -- FIXME: This should detect if there is a quickfix list first.
        vim.cmd([[silent! cn]])
    end
end, default_opts)
map({ 'n' }, '<C-p>', function()
    if require('trouble').is_open({}) then
        require('trouble').prev({ jump = true })
    else
        vim.cmd([[silent! cp]])
    end
end, default_opts)

local function add_search_count_hl(keybind, desc)
    map({ 'n', 'x', 'v' }, keybind, function()
        vim.api.nvim_feedkeys(keybind, 'n', false)
        vim.schedule(function()
            require("utils.search_count").hl_search()
        end)
    end, { desc = desc })
end
add_search_count_hl('n', 'Goto next' )
add_search_count_hl('N', 'Goto previous' )
add_search_count_hl('*', 'Search forward under cursor' )
add_search_count_hl('#', 'Search backward under cursor' )

map({ 'n', 'x', 'v' }, 'gl', '$', default_opts)
map({ 'n', 'x', 'v' }, 'gh', '^', default_opts)

map({ 'n' }, 'ZZ', '<cmd>qa<CR>', default_opts)
map({ 'n' }, '<leader>z', '<cmd>q<CR>', default_opts)

map({ 'n' }, '<leader>crr', '<cmd>OverseerRun<CR>', default('Overseer run'))
map({ 'n' }, '<leader>cra', '<cmd>OverseerQuickAction<CR>', default('Overseer quick actions'))
map({ 'n' }, '<leader>crt', '<cmd>OverseerToggle<CR>', default('Toggle Overseer window'))

-- Marks
map({ 'n' }, '<leader>m', '<cmd>lua require("telescope.builtin").marks()<CR>')

-- Replaced with marks.nvim
-- map({ 'n' }, 'dm', 'hi', {
--     noremap = true,
--     silent = true,
--     callback = function()
--         vim.ui.input({ prompt = 'Mark to delete' }, function(mark)
--             if mark then
--                 vim.cmd([[delmarks ]] .. mark)
--             end
--         end)
--     end,
-- })

map({ 'n' }, '<leader>al', '<cmd>SessionSearch<CR>', { desc = 'Session load' })
map({ 'n' }, '<leader>ad', '<cmd>Autosession delete<CR>', { desc = 'Session delete' })

-- q: is also useful...
map('n', '<leader>B', '<cmd>BufferLinePick<cr>', default('Open Bufferline Picker'))
map('n', '<leader>as', function()
    require('utils.tabs').setup_tabs(true)
end, default('Tab setup'))
