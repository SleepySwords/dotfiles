local M = {}
local DEFAULT_OPTS = { noremap = true, silent = true }

local map_key = vim.api.nvim_set_keymap

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

function M.setup()
    require('syntax-tree-surfer').setup()
    -- Visual Selection from Normal Mode
    map_desc(
        'n',
        '<leader>lm',
        '<cmd>STSSelectMasterNode<cr>',
        'Treesurfer select master node',
        DEFAULT_OPTS
    )
    map_desc(
        'n',
        '<leader>ln',
        '<cmd>STSSelectCurrentNode<cr>',
        'Treesurfer select current node',
        DEFAULT_OPTS
    )

    -- Select Nodes in Visual Mode
    vim.keymap.set('x', 'J', '<cmd>STSSelectNextSiblingNode<cr>', DEFAULT_OPTS)
    vim.keymap.set('x', 'K', '<cmd>STSSelectPrevSiblingNode<cr>', DEFAULT_OPTS)
    vim.keymap.set('x', 'H', '<cmd>STSSelectParentNode<cr>', DEFAULT_OPTS)
    vim.keymap.set('x', 'L', '<cmd>STSSelectChildNode<cr>', DEFAULT_OPTS)

    -- Swapping Nodes in Visual Mode
    map_desc('x', 'mj', '<cmd>STSSwapNextVisual<cr>', 'Treesurfer swap next element', DEFAULT_OPTS)
    map_desc('x', 'mk', '<cmd>STSSwapPrevVisual<cr>', 'Treesurfer swap previous element', DEFAULT_OPTS)
end

return M
