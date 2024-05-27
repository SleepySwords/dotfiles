return {
    "lukas-reineke/headlines.nvim",
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
            headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4" },
        }
    },
};
