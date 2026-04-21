return {
    {
        'nvim-mini/mini.jump',
        version = false,
        -- enabled = false,
        config = function(opts)
            local MiniJump = require("mini.jump")

            MiniJump.setup(opts)

            local jump_direction = false
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniJumpStart",
                group = vim.api.nvim_create_augroup("minijump_save_dir", { clear = true }),
                callback = function()
                    jump_direction = MiniJump.state.backward
                end,
            })
            vim.keymap.set({ "n", "x", "o" }, ";", function()
                MiniJump.jump(nil, jump_direction, nil, vim.v.count1)
            end)
            vim.keymap.set({ "n", "x", "o" }, ",", function()
                MiniJump.jump(nil, not jump_direction, nil, vim.v.count1)
            end)

            local esc_key = vim.keycode("<Esc>")
            vim.on_key(function(_, key)
                if MiniJump.state.jumping and key == esc_key then
                    MiniJump.stop_jumping()
                end
            end, vim.api.nvim_create_namespace("mini_jump_esc"))
        end,
        opts = {
            mappings = {
                repeat_jump = '',
            },
            delay = {
                highlight = 0,
                -- Delay between jump and automatic stop if idle (no jump is done)
                idle_stop = 10000000,
            },

            -- Whether to disable showing non-error feedback
            -- This also affects (purely informational) helper messages shown after
            -- idle time if user input is required.
            silent = false,
        }
    },
}
