local completion_engine = require('completion.engine.cmp-capatibilities')

local lsp_config = require('lspconfig')

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.formatting.dynamicRegistration = false
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

M.capabilities = capabilities

function M.setup()
    lsp_config.rust_analyzer.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
        settings = {
            ['rust-analyzer'] = {
                inlayHints = {
                    chainingHints = {
                        enable = false,
                    },
                },
            },
        },
    }))
    lsp_config.lua_ls.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        -- before_init = require("neodev.lsp").before_init,
        root_dir = function()
            return vim.fn.getcwd()
        end,
        settings = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
            },
        },
    }))
    lsp_config.kotlin_language_server.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.arduino_language_server.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        cmd = {
            'arduino-language-server',
            '-cli-config',
            '/Users/ibrahimhizamul/Library/Arduino15/arduino-cli.yaml',
            '-fqbn',
            'arduino:avr:uno',
            '-cli',
            'arduino-cli',
            '-clangd',
            'clangd',
        },
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.jdtls.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.jsonls.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.volar.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.ts_ls.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.pyright.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.hls.setup(completion_engine.provide_capabilities({
        settings = {
            haskell = {
                plugin = {
                    rename = { config = { crossModule = true } },
                },
            },
        },
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.clangd.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.wgsl_analyzer.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.zls.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    -- lsp_config.biome.setup(completion_engine.provide_capabilities({
    -- 	capabilities = capabilities,
    -- 	root_dir = function()
    -- 		return vim.fn.getcwd()
    -- 	end
    -- }))

    lsp_config.marksman.setup({})
    lsp_config.texlab.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.java_language_server.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        cmd = function()
            vim.fn.expand('$HOME/lsp/java-langauge-server')
        end,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    lsp_config.eslint.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
    -- lsp_config.tailwindcss.setup(completion_engine.provide_capabilities({
    --     capabilities = capabilities,
    --     root_dir = function()
    --         return vim.fn.getcwd()
    --     end,
    -- }))
    lsp_config.gopls.setup(completion_engine.provide_capabilities({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
end

-- This is a special case, as omnisharp needs extended.
function M.setup_omni()
    lsp_config.omnisharp.setup(completion_engine.provide_capabilities({
        handlers = {
            ['textDocument/definition'] = require('omnisharp_extended').handler,
        },
        capabilities = capabilities,
        cmd = { vim.env.HOME .. '/.local/share/nvim/mason/packages/omnisharp/omnisharp' },
        root_dir = function()
            return vim.fn.getcwd()
        end,
    }))
end

return M
