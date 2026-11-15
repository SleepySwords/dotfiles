-- Why do i have lazygit if i have toggle term??!?!!
return {
    {
        'kdheepak/lazygit.nvim',
        enabled = false,
        keys = {
            { '<leader>g', '<cmd>LazyGit<CR>', mode = 'n', desc = 'Open lazygit' }
        }

    },
    {
        'akinsho/toggleterm.nvim',
        enabled = false,
        keys = {
            { '<leader>Tt', '<cmd>ToggleTerm<CR>',                      noremap = true, mode = 'n', desc = 'Open toggle term in a new window' },
            { '<leader>Tf', '<cmd>ToggleTerm direction=float<CR>',      noremap = true, mode = 'n', desc = 'Open toggle term in a floating window' },
            { '<leader>Tv', '<cmd>ToggleTerm direction=vertical<CR>',   noremap = true, mode = 'n', desc = 'Open toggle term in a vertical window' },
            { '<leader>Th', '<cmd>ToggleTerm direction=horizontal<CR>', noremap = true, mode = 'n', desc = 'Open toggle term in a horizontal window' },
        },
        config = function()
            require('toggleterm').setup({
                size = function(term)
                    if term.direction == 'horizontal' then
                        return vim.o.lines * 0.4
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.4
                    end
                end,
            })
        end,
    },
}
