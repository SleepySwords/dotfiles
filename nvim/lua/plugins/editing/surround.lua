-- Surround commands (ysiw')
-- Keybinds: ys, ds, cs,
local keymaps = {
    -- insert          = '<C-g>z',
    -- insert_line     = 'gC-ggZ',
    normal = 'gsa',
    normal_cur = 'gSa',
    normal_line = 'gsgs',
    normal_cur_line = 'gSgS',
    visual = 'gsa',
    visual_line = 'gSa',
    delete = 'gsd',
    change = 'gsc',
}
return {
    {
        'kylechui/nvim-surround',
        config = function()
            vim.keymap.set({ 'n', 'x' }, 's', '<nop>', {})
            -- FIXME: may change this to omit the g, having flash use the g instead.
            vim.g.nvim_surround_no_normal_mappings = true
            -- See `:h nvim-surround.keymaps`
            vim.keymap.set("n", "sa", "<Plug>(nvim-surround-normal)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("n", "sla", "<Plug>(nvim-surround-normal-cur)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("n", "sna", "<Plug>(nvim-surround-normal-line)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("n", "slna", "<Plug>(nvim-surround-normal-cur-line)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("n", "sd", "<Plug>(nvim-surround-delete)", {
                desc = "Delete a surrounding pair",
            })
            vim.keymap.set("n", "sc", "<Plug>(nvim-surround-change)", {
                desc = "Change a surrounding pair",
            })
            vim.keymap.set("x", "sa", "<Plug>(nvim-surround-visual)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("x", "sla", "<Plug>(nvim-surround-visual-line)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("n", "scl", "<Plug>(nvim-surround-change-line)", {
                desc = "Change a surrounding pair",
            })
        end,
    },

    { 'nvim-mini/mini.surround', enabled = false, version = false },
}
