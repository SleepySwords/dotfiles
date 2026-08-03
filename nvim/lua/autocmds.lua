local enabled_inlay_hints = false
local setup_tabs_on_start = false
local render_latex_onwrite = false
local diagnostic_on_wait = false


local setup_terminal = require("utils.tabs").setup_terminal


-- Highlights when yannking (y)
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end
})

local group = vim.api.nvim_create_augroup('Term', {})

vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    desc = 'set option terminal',
    callback = setup_terminal,
})

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
        if not normal.bg then
            return
        end
        io.write(string.format('\027]11;#%06x\027\\', normal.bg))
    end,
})

vim.api.nvim_create_autocmd('UILeave', {
    callback = function()
        io.write('\027]111\027\\')
    end,

})

-- Treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function() vim.treesitter.start() end,
})

if setup_tabs_on_start then
    local setup_tabs = require("utils").setup_tabs
    vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
            setup_tabs(false)
        end,
    })
end

if render_latex_onwrite then
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = "*.md",
        callback = require("mathjax").render_latex
    })
end
--

-- Shows error diagnostics on cursor hold

if diagnostic_on_wait then
    vim.api.nvim_create_autocmd('CursorHold', {
        group = vim.api.nvim_create_augroup('DiagnosticHoldAttach', {}),
        callback = function(_)
            vim.diagnostic.open_float({ focusable = false })
        end,
    })
end

if enabled_inlay_hints then
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('InlayHintsAttach', {}),
        callback = function(args)
            local buf = args.buf
            vim.lsp.inlay_hint(buf, true)
        end,
    })
end
