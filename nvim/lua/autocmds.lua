-- Highlights when yannking (y)
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    command = "silent! lua require'vim.highlight'.on_yank()"
})

local function setup_terminal()
    vim.opt_local["number"] = false
    vim.opt_local["relativenumber"] = false
    vim.opt_local["filetype"] = "terminal"
    vim.opt_local["buflisted"] = false
end

local group = vim.api.nvim_create_augroup('Term', {})

vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    desc = 'set option terminal',
    callback = setup_terminal,
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then return end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function() io.write("\027]111\027\\") end,
})

vim.g.has_setup_tabs = false;

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if not vim.g.has_setup_tabs and vim.bo.filetype ~= '' and vim.bo.filetype ~= 'dashboard' and vim.bo.filetype ~= 'NvimTree' then
            vim.cmd('tab split')
            vim.cmd('tab split')
            vim.cmd('vsplit')
            vim.cmd('exec "norm \\<C-w>w"')
            vim.cmd('terminal')
            setup_terminal()
            local tab_names = { "Code", "Debug", "Terminal" }
            for _, v in ipairs(vim.api.nvim_list_tabpages()) do
                if tab_names[v] ~= nil then
                    vim.api.nvim_tabpage_set_var(v, "name", tab_names[v]);
                end
            end
            vim.api.nvim_set_current_tabpage(1);
            vim.g.has_setup_tabs = true
        end
    end
})
