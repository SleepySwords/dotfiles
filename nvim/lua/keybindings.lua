local g = vim.g

local map_key = vim.api.nvim_set_keymap
local function map(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == 'string' then
        modes = { modes }
    end
    for _, mode in ipairs(modes) do
        map_key(mode, lhs, rhs, opts)
    end
end

local function map_desc(modes, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    opts.desc = desc
    if type(modes) == 'string' then
        modes = { modes }
    end
    for _, mode in ipairs(modes) do
        map_key(mode, lhs, rhs, opts)
    end
end

g.mapleader = [[ ]]
g.maplocalleader = [[\]]

local opts = { noremap = true, silent = true }

-- TODO: Really need to check if these keybindings override some other default bindings.
map_desc({ 'n' }, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', 'LSP Declaration', opts)
map_desc({ 'n' }, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'LSP Definition', opts)
map_desc({ 'n' }, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'LSP Implementation', opts)

-- FIXME: I need to decide if i like the default keybinds or not (grn)
-- they can be removed see :help grn
-- map_desc({ 'n' }, 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', 'LSP Rename', opts)
map_desc({ 'n' }, 'grr', '<cmd>Trouble lsp_references toggle follow=true focus=true auto_refresh=false<CR>',
    'LSP References', opts) -- lua vim.lsp.buf.references()

map_desc(
    { 'n' },
    '<leader>k',
    '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    'LSP Signature Help',
    opts
)
map_desc(
    { 'n' },
    '<leader>cwa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    'LSP Add Workspace',
    opts
)
map_desc(
    { 'n' },
    '<leader>cwr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    'LSP Remove Workspace',
    opts
)
map_desc(
    { 'n' },
    '<leader>cwl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    'LSP List Workspaces',
    opts
)
map_desc(
    { 'n' },
    '<leader>w',
    '',
    'Which-key window',
    {
        noremap = true,
        silent = true,
        callback = function()
            require("which-key").show({
                keys = "<c-w>",
                loop = true, -- this will keep the popup open until you hit <esc>
            })
        end
    }
)
map_desc(
    { 'n' },
    '<leader>TD',
    '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    'LSP Type Definition',
    opts
)
map_desc({ 'n' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'LSP Code Action', opts)
map_desc(
    { 'n' },
    '<leader>ci',
    '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
    'LSP Code Action',
    opts
)
map_desc(
    { 'n' },
    '<space>e',
    '<cmd>lua vim.diagnostic.open_float()<CR>',
    'LSP Open Diagnostics float',
    opts
)
map_desc({ 'n' }, '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'LSP Previous Diagnostic', opts)
map_desc({ 'n' }, ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', 'LSP Next Diagnostic', opts)
map_desc({ 'n' }, '<space>dqf', '<cmd>lua vim.diagnostic.setqflist()<CR>', 'LSP Set Loclist', opts)
map_desc(
    { 'n' },
    '<space>cf',
    '<cmd>lua vim.lsp.buf.format { async = true, filter = function(client) return client.name ~= "tsserver" end }<CR>',
    'LSP Format',
    opts
)
map_desc({ 'n' }, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', 'LSP Hover')

map_desc({ 'n' }, '<leader>xx', '<cmd>Trouble toggle<CR>', 'Trouble Toggle', opts)
map_desc(
    { 'n' },
    '<leader>xe',
    '<cmd>Trouble workspace_diagnostics toggle<CR>',
    'Trouble workspace diagnostics',
    opts
)
map_desc(
    { 'n' },
    '<leader>cd',
    '<cmd>Trouble diagnostics toggle<CR>',
    'Trouble document diagnostics',
    opts
)
map_desc({ 'n' }, '<leader>xq', '<cmd>Trouble quickfix toggle<CR>', 'Trouble quickfix', opts)
map_desc({ 'n' }, '<leader>xt', '<cmd>TodoTrouble<CR>', 'Troule todo', opts)
map_desc(
    { 'n' },
    '<leader>xn',
    '<cmd>lua require("trouble").next({skip_groups = true, jump = true});<CR>',
    'Trouble next',
    opts
)
map_desc(
    { 'n' },
    '<leader>xp',
    '<cmd>lua require("trouble").previous({skip_groups = true, jump = true});<CR>',
    'Trouble previous',
    opts
)


-- LSP Saga (Until LSP Sage is fixed)
-- map('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
-- map('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
-- map('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
-- map('n', '<leader>dg', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)

-- map('n', '<leader>d', "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", opts) -- or open_float_terminal('lazygit')<CR>
-- map('t', '<leader>d', "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", opts)

map_desc('n', '<leader>g', '<cmd>LazyGit<CR>', 'Opens up LazyGit', opts)

-- map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
-- map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
-- map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

-- Bindings for Telescope and Nvim Tree
map_desc(
    { 'n' },
    '<leader>f',
    '<cmd>lua require("telescope.builtin").find_files(vim.g.telescope_theme)<CR>',
    'Open File Picker',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>ag',
    '<cmd>lua require("telescope.builtin").live_grep(vim.g.telescope_theme)<cr>',
    'Open Live Grep',
    { noremap = true }
)
map_desc(
    'n',
    '<leader>b',
    '<cmd>lua require("telescope.builtin").buffers(vim.g.telescope_theme)<cr>',
    'Open Buffer Picker',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>ht',
    '<cmd>lua require("telescope.builtin").help_tags(vim.g.telescope_theme)<cr>',
    'Open Help Tags',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>hh',
    '<cmd>lua require("telescope.builtin").highlights(vim.g.telescope_theme)<cr>',
    'Open Help Tags',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>lg',
    '<cmd>lua require("telescope.builtin").git_files(vim.g.telescope_theme)<cr>',
    'Open Git Files',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>S',
    '<cmd>lua require("telescope.builtin").lsp_document_symbols(vim.g.telescope_theme)<cr>',
    'Open document symbols',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>TD',
    '<cmd>lua require("telescope.builtin").diagnostics(vim.g.telescope_theme)<cr>',
    'Open telescope diagnostics',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>TR',
    '<cmd>lua require("telescope.builtin").lsp_references(vim.g.telescope_theme)<cr>',
    'Open telescope references',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>s',
    '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols(require("navigation.telescope").get_telescope_theme({path_display = "hidden" }))<cr>',
    'Open workspace symbols',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader><C-s>',
    '<cmd>lua require("telescope.builtin").lsp_workspace_symbols(require("navigation.telescope").get_telescope_theme({path_display = "hidden" }))<cr>',
    'Open workspace symbols',
    { noremap = true }
)
map_desc({ 'n' }, '<leader>u',
    '<cmd>UndotreeToggle<cr>',
    'Undo tree', { noremap = true });

local command =
[[<cmd>lua require("telescope.builtin").colorscheme(require("navigation.telescope").get_telescope_theme({enable_preview = true, layout_config = { horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8, }, vertical = { mirror = false, }, width = 0.5, height = 0.5, preview_cutoff = 120, }, }))<cr>]]

map_desc({ 'n' }, '<leader>cs', command, 'Open Colour Scheme', { noremap = true })
map_desc({ 'n' }, '<leader>t', '<cmd>NvimTreeToggle<CR>', 'Open File Tree', { noremap = true })
map_desc({ 'n' }, '<leader>ar', '<cmd>NvimTreeRefresh<CR>', 'Refresh File Tree', { noremap = true })
map_desc(
    { 'n' },
    '<leader>an',
    '<cmd>NvimTreeFindFile<CR>',
    'Find Current File In Tree',
    { noremap = true }
)

map_desc(
    { 'n' },
    '<leader>cts',
    '<cmd>Neotest summary<CR>',
    'Open summary test window',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>cto',
    '<cmd>Neotest output<CR>',
    'Open output test window',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>ctd',
    '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
    'Run test while attaching debug',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>ctR',
    '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>',
    'Run all tests',
    { noremap = true }
)
map_desc(
    { 'n' },
    '<leader>ctr',
    '<cmd>lua require("neotest").run.run()<CR>',
    'Run current test',
    { noremap = true }
)

map_desc({ 'n' }, '<leader>j', '<cmd>HopWord<CR>', 'hop word', { noremap = true })

-- Keybind for https://vi.stackexchange.com/questions/24502/deleting-without-copying-to-clipboard-in-windows
-- https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
map_desc({ 'n', 'v' }, '\\', '"_', 'Blackhole Register', { noremap = true })

-- Moving chunks of code using tab and shift tab in visual mode
map_desc({ 'v' }, '<Tab>', '>gv', 'Visual-Mode Indent Code', { noremap = true })
map_desc({ 'v' }, '<S-Tab>', '<gv', 'Visual-Mode Outdent Code', { noremap = true })

map({ 'v' }, '>', '>gv', { noremap = true })
map({ 'v' }, '<', '<gv', { noremap = true })

-- map({ 'n' }, '>', '>>', opts)
-- map({ 'n' }, '<', '<<', { noremap = true })

-- Buffer handling
map_desc(
    { 'n' },
    '<leader>L',
    '<cmd>if &rnu | set nornu | else | set rnu | endif<CR>',
    'Change Between Relative'
)
map_desc({ 'n' }, '<leader>n', '<cmd>bnext<CR>', 'Goto Next Buffer')
map_desc({ 'n' }, '<leader>p', '<cmd>bprevious<CR>', 'Goto Prev Buffer')
map_desc({ 'n' }, '<leader>q', '<cmd>BufDel<CR>', 'Delete The Current Buffer')
map({ 'n' }, '<leader>ls', '<cmd>ls<CR>')
map({ 'n' }, '<leader>0', '<cmd>set invnumber<CR>')

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
    '<cmd>lua require"telescope".extensions.dap.commands(vim.g.telescope_theme)<CR>'
)
map(
    { 'n' },
    '<leader>dto',
    '<cmd>lua require"telescope".extensions.dap.configurations(vim.g.telescope_theme)<CR>'
)
map(
    { 'n' },
    '<leader>dlb',
    '<cmd>lua require"telescope".extensions.dap.list_breakpoints(vim.g.telescope_theme)<CR>'
)
map(
    { 'n' },
    '<leader>dv',
    '<cmd>lua require"telescope".extensions.dap.variables(vim.g.telescope_theme)<CR>'
)
map(
    { 'n' },
    '<leader>df',
    '<cmd>lua require"telescope".extensions.dap.frames(vim.g.telescope_theme)<CR>'
)
map(
    { 'n' },
    '<leader>ds',
    '<cmd>lua require("dapui").float_element("scopes", { position = "center", enter = true, height = 40, width = 150 })<CR>'
)

-- Terminal
map({ 't' }, '<C-esc>', [[<C-\><C-n>]], { noremap = true })
map({ 'n' }, '<leader>Tt', '<cmd>ToggleTerm<CR>', { noremap = true })
map({ 'n' }, '<leader>Tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true })
map({ 'n' }, '<leader>Tv', '<cmd>ToggleTerm direction=vertical<CR>', { noremap = true })
map({ 'n' }, '<leader>Th', '<cmd>ToggleTerm direction=horizontal<CR>', { noremap = true })

map({ 'n' }, '<leader>Tn', '<cmd>tab split<cr>')

-- Be able to move chunks of code
map({ 'n' }, '<C-j>', '<cmd>:m .+1<CR>==', opts)
map({ 'n' }, '<C-k>', '<cmd>:m .-2<CR>==', opts)
map({ 'v' }, '<C-j>', ":move'>+<CR>gv=gv", opts)
map({ 'v' }, '<C-k>', ':move-2<CR>gv=gv', opts)

-- TODO: decide on one for quick fix
map({ 'n' }, ']q', ':cn<CR>', opts)
map({ 'n' }, '[q', ':cp<CR>', opts)

-- map({ 'n' }, '<C-n>', ':cn<CR>', opts)
-- map({ 'n' }, '<C-p>', ':cp<CR>', opts)

map({ 'n' }, '<C-n>', '', vim.tbl_extend('keep', opts, {
    callback = function()
        if require "trouble".is_open({}) then
            require("trouble").next({ jump = true });
        else
            -- FIXME: This should detect if there is a quickfix list first.
            vim.cmd [[silent! cn]]
        end
    end
}))
map({ 'n' }, '<C-p>', '', vim.tbl_extend('keep', opts, {
    callback = function()
        if require "trouble".is_open({}) then
            require("trouble").prev({ jump = true });
        else
            vim.cmd [[silent! cp]]
        end
    end
}))

map({ 'n', 'x', 'v' }, 'gl', '$', opts)
map({ 'n', 'x', 'v' }, 'gh', '^', opts)

map({ 'n' }, 'ZZ', '<cmd>qa<CR>', opts)
map_desc({ 'n' }, '<leader>cor', '<cmd>OverseerRun<CR>', 'Overseer run', opts)
map_desc({ 'n' }, '<leader>coa', '<cmd>OverseerQuickAction<CR>', 'Overseer quick actions', opts)
map_desc({ 'n' }, '<leader>coc', '<cmd>CompilerOpen<CR>', 'Open compiler', opts)
map_desc({ 'n' }, '<leader>cot', '<cmd>OverseerToggle<CR>', 'Toggle Overseer window', opts)

-- Marks
map({ 'n' }, '<leader>m',
    '<cmd>lua require("telescope.builtin").marks(vim.g.telescope_theme)<CR>'
)
map({ 'n' }, 'dm', 'hi', {
    noremap = true,
    silent = true,
    callback = function()
        vim.ui.input({ prompt = 'Mark to delete' }, function(mark)
            if mark then
                vim.cmd([[delmarks ]] .. mark)
            end
        end);
    end
})

-- Harpoon
-- map({ 'n' }, '<leader>mm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
-- map({ 'n' }, '<leader>mn', '<cmd>lua require("harpoon.ui").nav_next()<cr>', opts)
-- map({ 'n' }, '<leader>mp', '<cmd>lua require("harpoon.ui").nav_prev()<cr>', opts)
-- map({ 'n' }, '<leader>ma', '<cmd>lua require("harpoon.mark").toggle_file()<cr>', opts)
-- map({ 'n' }, '<leader>mr', '<cmd>lua require("harpoon.mark").create_mark()<cr>', opts)
