-- Adds statuscol plugin, allows for the down arrow folds.
return {
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require('statuscol.builtin')
            require('statuscol').setup({
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc, ' '}, click = 'v:lua.ScFa' },
                    { text = { '%s' }, click = 'v:lua.ScSa' },
                    { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                },
            })
        end,
    },

    {
        'chentoast/marks.nvim',
        opts = {
            refresh_interval = 1000,
            sign_priority = 5,
        },
    },
}
