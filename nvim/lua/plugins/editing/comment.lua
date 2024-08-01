return {
    -- Able to comment stuff out, gcc
    { 'tpope/vim-commentary', enabled = false },
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    }
}
