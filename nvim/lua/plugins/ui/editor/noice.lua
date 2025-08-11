-- FIXME: Incorporate the number of searches found into the status line if using this.
return {
    'folke/noice.nvim',
    -- enabled = false,
    event = 'VeryLazy',
    opts = {
        lsp = {
            progress = {
                enabled = false,
            },
            signature = {
                enabled = false,
            },
        },
        cmdline = {
            enabled = true,
            view = (not vim.g.neovide and "cmdline") or "cmdline_popup",
            format = {
                cmdline = false
            }
        },
        messages = {
            view = "mini",
            view_error = "mini",
            view_warn = "mini",
        },
        presets = {
            bottom_search = (not vim.g.neovide and true) or false,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
    },
    dependencies = {
        'MunifTanjim/nui.nvim',
        -- 'rcarriga/nvim-notify',
    },
}
