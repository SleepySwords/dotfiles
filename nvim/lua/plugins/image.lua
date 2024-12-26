if vim.g.neovide then
    return {}
end

package.path = package.path
    .. ';'
    .. vim.fn.expand('$HOME')
    .. '/.luarocks/share/lua/5.1/?/init.lua'
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua'

return {
    {
        'sleepyswords/mathjax.nvim',
        build = 'cd mathjax && yarn install',
        ft = 'markdown',
        -- config = function ()
        --     local mathjax = require("mathjax")
        --     vim.api.nvim_set_keymap('n', '<leader>mj', '', {
        --         callback = mathjax.render_latex,
        --         desc = 'Change function signature via quickfix list',
        --     })
        -- end,
        opts = {
            -- color = "red"
        },
        init = function()
            vim.api.nvim_create_autocmd('BufWrite', {
                pattern = '*.md',
                callback = function()
                    require('mathjax').render_latex()
                end,
            })
        end,
        dependencies = {
            {
                dir = vim.fn.expand('$HOME') .. '/stuff/dev/lua/image.nvim/',
                event = 'VeryLazy',
                -- dependencies = { "luarocks.nvim" },
                config = function()
                    -- default config
                    require('image').setup({
                        kitty_method = 'normal',
                        backend = 'kitty',
                        integrations = {
                            markdown = {
                                enabled = false,
                                clear_in_insert_mode = false,
                                download_remote_images = false,
                                only_render_image_at_cursor = false,
                                filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                            },
                            neorg = {
                                enabled = false,
                                clear_in_insert_mode = false,
                                download_remote_images = false,
                                only_render_image_at_cursor = false,
                                filetypes = { 'norg' },
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
                        -- FIXME: Investigate this, this is causing some errors
                        window_overlap_clear_enabled = false,
                        window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
                        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
                        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
                    })
                end,
            },
        },
    },
    -- {
    --     "vhyrro/luarocks.nvim",
    --     priority = 1000,     -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    --     config = true,
    --     opts = {
    --         rocks = { "magick" },
    --     },
    -- },
    -- {
    --     "nvim-neorg/neorg",
    --     dependencies = { "luarocks.nvim" },
    --     lazy = false,      -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    --     version = "*",     -- Pin Neorg to the latest stable release
    --     config = function()
    --         require("neorg").setup {
    --             load = {
    --                 ["core.defaults"] = {},
    --                 ["core.concealer"] = {},
    --                 ["core.integrations.image"] = {},
    --                 ["core.latex.renderer"] = {},
    --                 ["core.dirman"] = {
    --                     config = {
    --                         workspaces = {
    --                             notes = "~/notes",
    --                         },
    --                         default_workspace = "notes",
    --                     },
    --                 },
    --             },
    --         }
    --     end,
    -- }
}
