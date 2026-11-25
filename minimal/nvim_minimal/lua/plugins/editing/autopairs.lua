return {
    --- Quality of life stuff
    -- auto add the ending bracket
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            -- enable_check_bracket_line = false,
        },
    },
    {
        'windwp/nvim-ts-autotag',
        dependencies = {
            "nvim-treesitter"
        },
        opts = {
            enable_rename = false,
        }
    },
}
