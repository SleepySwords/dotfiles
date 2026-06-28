-- Based on https://github.com/nvim-lua/lsp-status.nvim/
-- Might replace with j-hui/fidget.nvim
--
-- Cannot format vim.lsp.status

local M = {}
local progress_messages = {}

---comment
---@param _ any
---@param request lsp.ProgressParams
---@param context any
local function handle_progress(_, request, context)
    local val = request.value
    local client_id = context.client_id

    if progress_messages[client_id] == nil then
        local client = vim.lsp.get_client_by_id(client_id)
        if client ~= nil then
            progress_messages[client_id] = {}
        else
            vim.notify("Client provided by progress request does not exist", vim.log.levels.WARN)
            return
        end
    end
    if val.kind == 'begin' then
        progress_messages[client_id][request.token] = {
            title = val.title,
            message = val.message,
            percentage = val.percentage,
        }
    elseif val.kind == 'report' then
        if not progress_messages[client_id][request.token] then
            return
        end
        progress_messages[client_id][request.token].message = val.message
        progress_messages[client_id][request.token].percentage = val.percentage
    elseif val.kind == 'end' then
        if not progress_messages[client_id][request.token] then
            return
        end
        progress_messages[client_id][request.token].message = val.message
        progress_messages[client_id][request.token].done = true
    end
    vim.cmd("redrawstatus!")
end

function M.register_progress_handler()
    vim.lsp.handlers['$/progress'] = handle_progress
end

local function limit(str, max_len)
    if #str > max_len then
        return str:sub(1, max_len - 1) .. "…"
    end
    return str
end

function M.progress()
    local to_remove = {}
    local messages = {}
    for client_id, progress in pairs(progress_messages) do
        local client = vim.lsp.get_client_by_id(client_id)
        if client == nil or client:is_stopped() then
            progress_messages[client_id] = nil
        else
            local client_name = client.name
            for token, msg in pairs(progress) do
                local display_message = '[' .. client_name .. ']' .. ' ' .. msg.title
                if msg.message ~= nil then display_message = display_message .. ' ' .. msg.message end
                if msg.percentage ~= nil then
                    display_message = display_message ..
                        ' (' .. string.format('%.0f', msg.percentage) .. '%%)'
                end
                table.insert(messages, display_message)

                if msg.done then
                    table.insert(to_remove, { client_id = client_id, token = token })
                end
            end
        end
    end

    for _, m in ipairs(to_remove) do
        progress_messages[m.client_id][m.token] = nil
    end

    return limit(table.concat(messages, ' '), 80)
end

return M
