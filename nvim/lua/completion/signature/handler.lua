-- NOTE: Be sure to update based on https://github.com/neovim/neovim/blob/c0a8abf18e060e60b8dfeddb3a24a0d371288e2a/runtime/lua/vim/lsp/handlers.lua#L485

local util = require('vim.lsp.util')
local protocol = require('vim.lsp.protocol')
local ms = protocol.Methods
local api = vim.api

local M = {
    orig_mappings = {},
    activeSignature = 0,
    signatures = {},
    enabled = true,
}

-- FIXME: Seperate command to focus signature.
-- Allow for overloading at the top (this breaks currently because of highlighting, so must change that too)
function M.signature_help(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if api.nvim_get_current_buf() ~= ctx.bufnr or not M.enabled then
        -- Ignore result since buffer changed. This happens for slow language servers.
        return
    end
    -- When use `autocmd CompleteDone <silent><buffer> lua vim.lsp.buf.signature_help()` to call signatureHelp handler
    -- If the completion item doesn't have signatures It will make noise. Change to use `print` that can use `<silent>` to ignore
    if not (result and result.signatures and result.signatures[1]) then
        M.close_window()
        if config.silent ~= true then
            print('No signature help available')
        end
        return
    end
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    local triggers =
        vim.tbl_get(client.server_capabilities, 'signatureHelpProvider', 'triggerCharacters')
    local ft = vim.bo[ctx.bufnr].filetype

    if not vim.deep_equal(result.signatures, M.signatures) then
        M.signatures = result.signatures
        M.activeSignature = result.activeSignature or 1
    else
        result.activeSignature = (M.activeSignature % #result.signatures)
    end

    local lines, hl = util.convert_signature_help_to_markdown_lines(result, ft, triggers)
    if not lines or vim.tbl_isempty(lines) then
        M.close_window()
        if config.silent ~= true then
            print('No signature help available')
        end
        return
    end
    if #result.signatures > 1 then
        table.insert(lines, '')
        table.insert(
            lines,
            '(Overloading '
                .. (result.activeSignature or 0) + 1
                .. ' of '
                .. #result.signatures
                .. ')'
        )
    end
    if M.is_window_and_buffer_valid() then
        vim.bo[M.fbuf].modifiable = true
        api.nvim_buf_set_lines(M.fbuf, 0, -1, false, lines)

        local width, height = util._make_floating_popup_size(lines, config)
        api.nvim_win_set_height(M.fwin, height)
        api.nvim_win_set_width(M.fwin, width)

        vim.bo[M.fbuf].modifiable = false
    else
        local newfbuf, newfwin = util.open_floating_preview(lines, 'markdown', config)
        M.fwin = newfwin
        M.fbuf = newfbuf
        M.create_keybinds()
    end
    if hl then
        -- Highlight the second line if the signature is wrapped in a Markdown code block.
        local line = vim.startswith(lines[1], '```') and 1 or 0
        api.nvim_buf_add_highlight(M.fbuf, -1, 'LspSignatureActiveParameter', line, unpack(hl))
    end
    return M.fbuf, M.fwin
end

function M.is_window_and_buffer_valid()
    return M.fwin
        and vim.api.nvim_win_is_valid(M.fwin)
        and M.fbuf
        and vim.api.nvim_buf_is_valid(M.fbuf)
end

function M.create_keybinds()
    M.orig_mappings.down = vim.fn.maparg('<C-j>', 'i', false, true)
    M.orig_mappings.up = vim.fn.maparg('<C-k>', 'i', false, true)
    M.orig_mappings.up = vim.fn.maparg('<C-s>', 'i', false, true)

    vim.keymap.set('i', '<C-j>', function()
        M.activeSignature = M.activeSignature + 1
        vim.lsp.buf.signature_help()
    end, { buffer = 0, expr = true, nowait = false })

    vim.keymap.set('i', '<C-k>', function()
        M.activeSignature = M.activeSignature - 1
        vim.lsp.buf.signature_help()
    end, { buffer = 0, expr = true, nowait = false })

    vim.keymap.set('i', '<C-s>', function()
        if not M.enabled then
            M.enabled = true
            vim.lsp.buf.signature_help()
        else
            M.enabled = false
            M.close_window()
        end
    end, { buffer = 0, expr = true, nowait = false })

    vim.api.nvim_create_autocmd('WinClosed', {
        pattern = tostring(M.fwin),
        callback = function()
            for _, mapping in ipairs(M.orig_mappings) do
                vim.fn.mapset(mapping)
            end
        end,
    })
end

-- This also automatically gets rid of the buffer
-- Since bufhidden is wipe.
function M.close_window()
    if M.fwin and vim.api.nvim_win_is_valid(M.fwin) then
        vim.schedule(function()
            pcall(api.nvim_win_close, M.fwin, true)
        end)
    end
end

local function attach_buffer(bufnr)
    vim.api.nvim_create_autocmd({
        'CursorMovedI',
        'CompleteDone' --[[ 'TextChangedI' ]],
    }, {
        callback = function()
            pcall(vim.lsp.buf.signature_help)
        end,
        buffer = bufnr,
    })
end

function M.setup()
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client ~= nil and client.server_capabilities.signatureHelpProvider then
                attach_buffer(args.buf)
            end
        end,
    })

    vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:[sS\x13i]',
        callback = function()
            if
                #vim.lsp.get_clients({
                    method = ms.textDocument_signatureHelp,
                    bufnr = 0,
                }) > 0
            then
                vim.lsp.buf.signature_help()
            end
        end,
    })

    vim.api.nvim_create_autocmd({
        'InsertLeave'
    }, {
        callback = function()
            M.enabled = true
        end,
    })

    vim.lsp.handlers[ms.textDocument_signatureHelp] = vim.lsp.with(M.signature_help, {
        close_events = { 'CursorMoved', 'WinScrolled' },
        anchor_bias = 'above',
        max_height = 5,
    })
end

return M
