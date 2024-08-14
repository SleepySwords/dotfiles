return {
    --- Quality of life stuff
    -- auto add the ending bracket
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup({
                -- enable_check_bracket_line = false,
            })
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        dependencies = {
            "nvim-treesitter"
        },
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    },
}
