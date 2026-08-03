return {
    -- Adds trouble which displays references, diagnostics
    'folke/trouble.nvim',
    enabled = false,
    dependencies = 'nvim-mini/mini.icons',
    keys = {
        { 'grt',        '<cmd>Trouble lsp_references toggle follow=true focus=true auto_refresh=false<CR>', mode = 'n',   desc = 'LSP References' },
        { '<leader>xx', '<cmd>Trouble toggle<CR>',                                                          mode = 'n',   desc = 'Trouble Toggle' },
        { '<leader>xd', '<cmd>Trouble workspace_diagnostics toggle<CR>',                                    mode = 'n',   desc = 'Trouble workspace diagnostics' },
        { '<leader>xe', '<cmd>Trouble diagnostics toggle<CR>',                                              mode = 'n',   desc = 'Trouble document diagnostics' },
        { '<leader>xq', '<cmd>Trouble quickfix toggle<CR>',                                                 mode = 'n',   desc = 'Trouble quickfix' },
        { '<leader>xt', '<cmd>TodoTrouble<CR>',                                                             mode = 'n',   desc = 'Troule todo' },
        { '<leader>xn', '<cmd>lua require("trouble").next({skip_groups = true, jump = true});<CR>',         mode = 'n',   desc = 'Trouble next' },
        { '<leader>xp', '<cmd>lua require("trouble").previous({skip_groups = true, jump = true});<CR>',     mode = 'n',   desc = 'Trouble previous' }
    },
    config = function()
        require('trouble').setup({
            action_keys = {
                jump = { '<tab>' },
                jump_close = { 'o', '<cr>' },
            },
        })
    end,
};
