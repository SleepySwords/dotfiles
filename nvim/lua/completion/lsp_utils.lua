local M = {}

function M.setup()
    if vim.fn.has('nvim-0.5.1') == 1 then
        vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
        vim.lsp.handlers['textDocument/references'] = require 'lsputil.locations'.references_handler
        vim.lsp.handlers['textDocument/definition'] = require 'lsputil.locations'.definition_handler
        vim.lsp.handlers['textDocument/declaration'] = require 'lsputil.locations'.declaration_handler
        vim.lsp.handlers['textDocument/typeDefinition'] = require 'lsputil.locations'.typeDefinition_handler
        vim.lsp.handlers['textDocument/implementation'] = require 'lsputil.locations'.implementation_handler
        vim.lsp.handlers['textDocument/documentSymbol'] = require 'lsputil.symbols'.document_handler
        vim.lsp.handlers['workspace/symbol'] = require 'lsputil.symbols'.workspace_handler
    end

    local function dump(o)
        if type(o) == 'table' then
            local s = '{ '
            for k, v in pairs(o) do
                if type(k) ~= 'number' then k = '"' .. k .. '"' end
                s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
            end
            return s .. '} '
        else
            return tostring(o)
        end
    end

    local function goto_definition(split_cmd)
        local util = vim.lsp.util
        local log = require("vim.lsp.log")
        local api = vim.api

        -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
        local handler = function(_, result, ctx)
            if result == nil or vim.tbl_isempty(result) then
                local _ = log.info() and log.info(ctx.method, "No location found")
                return nil
            end

            if split_cmd then
                vim.cmd(split_cmd)
            end

            if vim.tbl_islist(result) then
                util.jump_to_location(result[1])

                if #result > 1 then
                    -- FIX: investigae what this was doing.
                    -- util.setqflist(util.locations_to_items(result))
                    api.nvim_command("copen")
                    api.nvim_command("wincmd p")
                end
            else
                util.jump_to_location(result)
            end
        end

        return handler
    end

    vim.lsp.handlers["textDocument/definition"] = goto_definition()
end

return M
