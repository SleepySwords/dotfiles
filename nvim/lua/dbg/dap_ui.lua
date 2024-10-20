local M = {}

function M.setup()
    require('dapui').setup({
        controls = {
            icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "󰜉",
                step_back = "󰌍",
                step_into = "󰆹",
                step_out = "󰆸",
                step_over = "󰆷",
                terminate = ""
            }
        },
        icons = {
            expanded = '',
            current_frame = '',
            collapsed = '',
        },
        floating = {
            border = 'solid',
        },
        layouts = {
            {
                elements = {
                    'scopes',
                    'breakpoints',
                    'stacks',
                    'watches',
                },
                size = 40,
                position = 'left',
            },
            {
                elements = {
                    'repl',
                    'console',
                },
                size = 10,
                position = 'bottom',
            },
        },
    })
end

return M
