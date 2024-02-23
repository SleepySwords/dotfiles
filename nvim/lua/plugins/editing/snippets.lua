--  Code snippets support
return {
    'L3MON4D3/LuaSnip',
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        require('luasnip').config.set_config({
            history = true,
            updateevents = 'TextChanged,TextChangedI',
        })
        require('luasnip.loaders.from_vscode').lazy_load()
    end,
}
