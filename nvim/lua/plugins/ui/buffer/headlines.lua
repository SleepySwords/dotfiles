return {
    {
        "lukas-reineke/headlines.nvim",
        ft = "markdown",
        lazy = true,
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = {
            markdown = {
                bullets = {},
                bullet_highlights = {
                    "@text.title.1.markdown",
                    "@text.title.2.markdown",
                    "@text.title.3.markdown",
                    "@text.title.4.markdown",
                    "@text.title.5.markdown",
                    "@text.title.6.markdown",
                },
                fat_headline_lower_string = '',
                fat_headline_upper_string = '',
                headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4" },
            }
        }
    },

    {
        "OXY2DEV/markview.nvim",
        enabled = false,
        opts = {
            modes = { "n", "i", "c" },
            hybrid_modes = { "n", "i" },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    }
};
