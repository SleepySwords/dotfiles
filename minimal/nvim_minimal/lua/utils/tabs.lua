local M = {}

function M.setup_terminal()
    vim.opt_local['number'] = false
    vim.opt_local['relativenumber'] = false
    vim.opt_local['filetype'] = 'terminal'
    vim.opt_local['buflisted'] = false
end

vim.g.has_setup_tabs = false

function M.setup_tabs(term)
    if
        not vim.g.has_setup_tabs
        and vim.bo.filetype ~= ''
        and vim.bo.filetype ~= 'dashboard'
        and vim.bo.filetype ~= 'NvimTree'
    then
        vim.cmd('tab split')
        require('dapui').toggle()
        vim.cmd('tab split')
        vim.cmd('vsplit')
        if term ~= nil and term then
            vim.cmd('exec "norm \\<C-w>w"')
            vim.cmd('terminal')
            M.setup_terminal()
        end
        local tab_names = { 'Code', 'Debug', 'Terminal' }
        for _, v in ipairs(vim.api.nvim_list_tabpages()) do
            if tab_names[v] ~= nil then
                vim.api.nvim_tabpage_set_var(v, 'name', tab_names[v])
            end
        end
        vim.api.nvim_set_current_tabpage(1)
        vim.g.has_setup_tabs = true
    end
end

return M
