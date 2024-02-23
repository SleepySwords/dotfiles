require('noice').setup({
    messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = false, -- enables the Noice messages UI
        view = 'mini', -- default view for messages
        view_error = 'mini', -- view for errors
        view_warn = 'mini', -- view for warnings
        view_history = 'messages', -- view for :messages
        view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    -- presets = {
    -- 	bottom_search = true, -- use a classic bottom cmdline for search
    -- },
    lsp = {
        progress = {
            enabled = false,
        },
        signature = {
            enabled = false,
            auto_open = {
                enabled = true,
                trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = 'mini',
        },
    },
    views = {
        cmdline_popup = {
            border = {
                -- style = "none",
                -- padding = { 1, 2 },
                style = 'single',
            },
            filter_options = {},
            -- win_options = {
            -- 	winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            -- },
        },
        above_hover = {
            view = 'popup',
            relative = 'cursor',
            zindex = 45,
            enter = false,
            anchor = 'auto',
            reverse = true,
            size = {
                width = 'auto',
                height = 'auto',
                max_height = 20,
                max_width = 120,
            },
            border = {
                style = 'none',
                padding = { 0, 2 },
            },
            position = 'top',
            win_options = {
                wrap = true,
                linebreak = true,
            },
        },
    },
})
