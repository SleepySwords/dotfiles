-- Why do i have lazygit if i have toggle term??!?!!
return {
    {
        'kdheepak/lazygit.nvim',
        enabled = false,
        keys = {
            {'<leader>g', '<cmd>LazyGit<CR>', mode = 'n', desc = 'Open lazygit'}
        }

    },
    {
        'akinsho/toggleterm.nvim',
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
