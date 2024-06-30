if vim.g.neovide then
    return {}
end
return {
    {
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        config = function()
            -- default config
            require("image").setup({
                backend = "kitty",
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "markdown", "vimwiki" },     -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "norg" },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = true,                                          -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                editor_only_render_when_focused = false,                                      -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false,                                      -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },     -- render image files as images when opened
            })
        end
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,     -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        lazy = false,      -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*",     -- Pin Neorg to the latest stable release
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.integrations.image"] = {},
                    ["core.latex.renderer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            }
        end,
    }
}
