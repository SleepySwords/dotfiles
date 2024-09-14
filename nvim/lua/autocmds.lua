local setup_terminal = require("utils").setup_terminal
-- local setup_tabs = require("utils").setup_tabs


-- Highlights when yannking (y)
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    command = "silent! lua require'vim.highlight'.on_yank()",
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

-- vim.api.nvim_create_autocmd('BufEnter', {
--     callback = function()
--         setup_tabs(false)
--     end,
-- })
