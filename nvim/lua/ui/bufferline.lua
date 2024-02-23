local M = {}

function M.setup()
    local bufferline = require('bufferline')
    bufferline.setup({
        options = {
            numbers = 'both',
        },
        highlights = {
            indicator_selected = {
                bg = '#c678dd',
                fg = '#c678dd',
            },
        },
    })

    vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', {
        fg = '#c678dd',
    })
end

return M
