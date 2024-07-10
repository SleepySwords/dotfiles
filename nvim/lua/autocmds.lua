
-- Highlights when yannking (y)
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    command = "silent! lua require'vim.highlight'.on_yank()"
})

local has_setup_tabs = false;

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if not has_setup_tabs and vim.bo.filetype ~= '' and vim.bo.filetype ~= 'dashboard' and vim.bo.filetype ~= 'NvimTree' then
            vim.cmd('tab split')
            vim.cmd('tab split')
            vim.cmd('ToggleTerm direction=vertical')
            vim.api.nvim_tabpage_set_var(1, "name", "Code");
            vim.api.nvim_tabpage_set_var(2, "name", "Debug");
            vim.api.nvim_tabpage_set_var(3, "name", "Terminal");
            vim.api.nvim_set_current_tabpage(1);
            has_setup_tabs = true
        end
    end
})

local group = vim.api.nvim_create_augroup('Term', {})

vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    desc = 'set option terminal',
    callback = function()
        vim.opt_local["number"] = false
        vim.opt_local["relativenumber"] = false
        vim.opt_local["filetype"] = "terminal"
    end,
})
