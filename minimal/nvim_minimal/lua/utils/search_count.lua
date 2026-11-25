-- https://www.reddit.com/r/neovim/comments/xom3gm/search_results_inline_count_blink_a_simple/
local M = {}

local ns = vim.api.nvim_create_namespace("search")
local map = vim.keymap.set

function M.hl_search()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

    local sc = vim.fn.searchcount()
    vim.api.nvim_buf_set_extmark(0, ns, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
        virt_text = { { "[" .. sc.current .. "/" .. sc.total .. "]", "Comment" } },
        virt_text_pos = "eol",
    })
end

function M.map_search_count_hl(keybind, desc)
    map({ 'n', 'x', 'v' }, keybind, function()
        vim.api.nvim_feedkeys(keybind, 'n', false)
        vim.schedule(function()
            M.hl_search()
        end)
    end, { desc = desc })
end

return M
