local M = {}

local map_search_count_hl = require('utils.search_count').map_search_count_hl

local g = vim.g

local map = vim.keymap.set

local default_opts = { noremap = true, silent = true }

local function default(desc)
    return { desc = desc, noremap = true, silent = true }
end

local function map_plugin(key, action, desc)
    M[action] = { key = key, desc = desc }
end

g.mapleader = [[ ]]
g.maplocalleader = [[|]]

local function toggle_qf()
    if vim.iter(vim.api.nvim_tabpage_list_wins(0)):any(function(w) return vim.fn.win_gettype(w) == "quickfix" end) then
        vim.cmd("ccl")
    else
        vim.cmd("copen")
    end
end

map({ 'n' }, 'gd', function() vim.lsp.buf.definition() end, default('LSP Definition'))
map({ 'n' }, 'grd', function() vim.lsp.buf.declaration() end, default('LSP Declaration'))
map({ 'n' }, 'gri', function() vim.lsp.buf.implementation() end, default('LSP Implementation'))
map({ 'n' }, 'grn', function() vim.lsp.buf.rename() end, default('LSP Rename'))
map({ 'n' }, 'grt', function() vim.lsp.buf.type_definition() end, default('LSP Rename'))
map({ 'n' }, 'grr', function() vim.lsp.buf.references() end, default('LSP references in quick fix list'))

map({ 'n' }, '<leader>co', toggle_qf, default('Toggle quick fix list'))
map({ 'n' }, '<C-q>', toggle_qf, default('Toggle quick fix list'))
map({ 'n' }, '<leader>cc', '<cmd>caddexpr expand("%") .. ":" .. line(".") ..  ":" .. col(".") .. ":" .. getline(".")<CR>',
    { desc = 'Add current pos to quickfix' })

map({ 'n' }, '<leader>k', function() vim.lsp.buf.signature_help() end, default('LSP Signature Help'))
map({ 'n' }, '<leader>cwa', function() vim.lsp.buf.add_workspace_folder() end, default('LSP Add Workspace'))
map({ 'n' }, '<leader>cwr', function() vim.lsp.buf.remove_workspace_folder() end, default('LSP Remove Workspace'))
map({ 'n' }, '<leader>cwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    default('LSP List Workspaces'))

map({ 'n' }, '<leader>w', function() require('which-key').show({ keys = '<c-w>', loop = true, }) end,
    default('Which-key window'))

map({ 'n' }, '<leader>ca', function() vim.lsp.buf.code_action() end, default('LSP Code Action'))
map({ 'n' }, '<leader>ci', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    default('LSP Code Action'))
map({ 'n' }, '<leader>cl', function() vim.lsp.codelens.run() end, default('LSP Codelens run'))
map({ 'n' }, '<leader>e', function() vim.diagnostic.open_float() end, default('LSP Open Diagnostics float'))
map({ 'n' }, '[d', function() vim.diagnostic.jump({ count = -1 }) end, default('LSP Previous Diagnostic'))
map({ 'n' }, ']d', function() vim.diagnostic.jump({ count = 1 }) end, default('LSP Next Diagnostic'))
map({ 'n' }, '<space>dqf', function() vim.diagnostic.setqflist() end, default('LSP Set Loclist'))
map(
    { 'n' },
    '<space>cf',
    function() vim.lsp.buf.format { async = true, filter = function(client) return client.name ~= "tsserver" end } end,
    default('LSP Format')
)
map({ 'n' }, 'K', function() vim.lsp.buf.hover() end, default('LSP Hover'))

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
    function() require("telescope.builtin").live_grep() end,
    default('Open Live Grep')
)
map(
    'n',
    '<leader>b',
    function() require("telescope.builtin").buffers() end,
    default('Open Buffer Picker')
)
map(
    'n',
    '<leader>j',
    function() require("telescope.builtin").jumplist() end,
    default('Open Buffer Picker')
)
map(
    { 'n' },
    '<leader>ah',
    function() require("telescope.builtin").help_tags() end,
    default('Open Help Tags')
)
map(
    { 'n' },
    '<leader>at',
    '<cmd>TodoTelescope<CR>',
    default('Open todo')
)
map(
    { 'n' },
    '<leader>ah',
    function() require("telescope.builtin").highlights() end,
    default('Open Highlights')
)
map(
    { 'n' },
    '<leader>S',
    function() require("telescope.builtin").lsp_document_symbols() end,
    default('Open document symbols')
)
map(
    { 'n' },
    '<leader>D',
    function() require("telescope.builtin").diagnostics() end,
    default('Open telescope diagnostics')
)
map(
    { 'n' },
    '<leader>ar',
    function() require("telescope.builtin").lsp_references() end,
    default('Open telescope references')
)
map(
    { 'n' },
    '<leader>s',
    function() require("telescope.builtin").lsp_dynamic_workspace_symbols({ path_display = "hidden" }) end,
    default('Open workspace symbols')
)
map(
    { 'n' },
    '<leader><C-s>',
    function() require("telescope.builtin").lsp_workspace_symbols({ path_display = "hidden" }) end,
    default('Open workspace symbols')
)
map({ 'n' }, '<leader>u', '<cmd>UndotreeToggle<cr>', default('Undo tree'))

local function open_colourscheme()
    require("telescope.builtin").colorscheme({
        enable_preview = true,
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.5,
            height = 0.5,
            preview_cutoff = 120,
        },
    })
end
map({ 'n' }, '<leader>ac', open_colourscheme, default('Open Colour Scheme'))

map({ 'n' }, '<leader>o', '<cmd>Oil<CR>', default('Open File Tree'))

map({ 'n' }, '<leader>cts', '<cmd>Neotest summary<CR>', default('Open summary test window'))
map({ 'n' }, '<leader>cto', '<cmd>Neotest output<CR>', default('Open output test window'))
map(
    { 'n' },
    '<leader>ctd',
    function() require("neotest").run.run({ strategy = "dap" }) end,
    default('Run test while attaching debug')
)
map(
    { 'n' },
    '<leader>ctR',
    function() require("neotest").run.run(vim.fn.getcwd()) end,
    default('Run all tests')
)
map(
    { 'n' },
    '<leader>ctr',
    function() require("neotest").run.run() end,
    default('Run current test')
)

-- Keybind for https://vi.stackexchange.com/questions/24502/deleting-without-copying-to-clipboard-in-windows
-- https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
map({ 'n', 'v' }, '\\', '"_', { desc = 'Blackhole Register', noremap = true })

-- Moving chunks of code using tab and shift tab in visual mode
map({ 'v' }, '>', '>gv', { noremap = true })
map({ 'v' }, '<', '<gv', { noremap = true })

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
map({ 'n' }, '<leader>0', '<cmd>set invnumber<CR>', default('Set current line number to 0 or not'))
map({ 'n' }, '<leader>ll', '<cmd>ls<CR>', default('Print ls'))

-- Buffer handling
map({ 'n' }, '<leader>n', '<cmd>bnext<CR>', default('Next buffer'))
map({ 'n' }, '<leader>p', '<cmd>bprevious<CR>', default('Previous buffer'))
map({ 'n' }, '<leader>q', function() Snacks.bufdelete() end, default('Delete buffer'))
map({ 'n' }, '<leader>Q', function() Snacks.bufdelete.other() end, default('Delete all other buffers'))

-- Debugging
map({ 'n' }, '<leader>dc', function() require "dap".continue() end)
map({ 'n' }, '<leader>dn', function() require "dap".step_over() end)
map({ 'n' }, '<leader>di', function() require "dap".step_into() end)
map({ 'n' }, '<leader>do', function() require "dap".step_out() end)
map({ 'n' }, '<leader>db', function() require "dap".toggle_breakpoint() end)
map({ 'n' }, '<leader>dh', function() require "dapui".eval() end)
map(
    { 'n' },
    '<leader>dsbr',
    function() require "dap".set_breakpoint(vim.fn.input("Breakpoint condition: ")) end
)
map(
    { 'n' },
    '<leader>dsbm',
    function() require "dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end
)
map({ 'n' }, '<leader>dro', function() require "dap".repl.open() end)
map({ 'n' }, '<leader>drl', function() require "dap".repl.run_last() end)

map({ 'n' }, '<leader>dui', function() require "dapui".toggle() end)

-- Debugger Info
map(
    { 'n' },
    '<leader>dtc',
    function() require "telescope".extensions.dap.commands() end
)
map(
    { 'n' },
    '<leader>dto',
    function() require "telescope".extensions.dap.configurations() end
)
map(
    { 'n' },
    '<leader>dlb',
    function() require "telescope".extensions.dap.list_breakpoints() end
)
map(
    { 'n' },
    '<leader>dv',
    function() require "telescope".extensions.dap.variables() end
)
map(
    { 'n' },
    '<leader>df',
    function() require "telescope".extensions.dap.frames() end
)
map(
    { 'n' },
    '<leader>ds',
    function() require("dapui").float_element("scopes", { position = "center", enter = true, height = 40, width = 150 }) end
)

-- Terminal
map({ 't' }, '<C-\\>', [[<C-\><C-n>]], { noremap = true })
map({ 'n' }, '<leader>Tn', '<cmd>tab split<cr>')

-- Be able to move chunks of code
-- map({ 'n' }, '<C-j>', '<cmd>:m .+1<CR>==', default_opts)
-- map({ 'n' }, '<C-k>', '<cmd>:m .-2<CR>==', default_opts)
-- map({ 'v' }, '<C-j>', ":move'>+<CR>gv=gv", default_opts)
-- map({ 'v' }, '<C-k>', ':move-2<CR>gv=gv', default_opts)

-- map({ 'n', 'x', 'v' }, 'gl', '$', default_opts)
-- map({ 'n', 'x', 'v' }, 'gh', '^', default_opts)

map({ 'n' }, '<C-n>', '<cmd>silent! cn<CR>', default_opts)
map({ 'n' }, '<C-p>', '<cmd>silent! cp<CR>', default_opts)

map_search_count_hl('n', 'Goto next')
map_search_count_hl('N', 'Goto previous')
map_search_count_hl('*', 'Search forward under cursor')
map_search_count_hl('#', 'Search backward under cursor')


map({ 'n' }, 'ZZ', '<cmd>qa<CR>', default_opts)
map({ 'n' }, '<leader>z', '<cmd>q<CR>', default_opts)

-- Marks
map({ 'n' }, '<leader>m', function() require("telescope.builtin").marks() end)

map('n', '<leader>B', '<cmd>BufferLinePick<cr>', default('Open Bufferline Picker'))
map('n', '<leader>as', function()
    require('utils.tabs').setup_tabs(true)
end, default('Tab setup'))

map({ 'n', 'v' }, '<leader>I', '<cmd>let @" = @+<CR>', default('Move the system clipboard into default register'))
map({ 'n', 'v' }, '<leader>O', '<cmd>let @+ = @"<CR>', default('Move the default register into the clipboard'))


map('ca', 'h', function()
    return (vim.fn.getcmdpos() == 2 and vim.fn.getcmdtype() == ":") and "vert bo h" or "h"
end, { expr = true })

map_plugin('<leader>t', 'open_ft', 'Open file tree')

return M
