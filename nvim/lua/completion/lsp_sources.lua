local lsp_config = require('lspconfig')

local M = {}

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {}
      )

function M.setup()
    lsp_config.rust_analyzer.setup({
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
    })
    lsp_config.lua_ls.setup({
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
    })
    lsp_config.kotlin_language_server.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.arduino_language_server.setup({
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
    })
    lsp_config.jdtls.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.jsonls.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.volar.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.ts_ls.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.pyright.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.hls.setup({
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
    })
    lsp_config.clangd.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.wgsl_analyzer.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.zls.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    -- lsp_config.biome.setup({
    -- 	capabilities = capabilities,
    -- 	root_dir = function()
    -- 		return vim.fn.getcwd()
    -- 	end
    -- })

    lsp_config.marksman.setup({})
    lsp_config.texlab.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    lsp_config.java_language_server.setup({
        capabilities = capabilities,
        cmd = function()
            vim.fn.expand('$HOME/lsp/java-langauge-server')
        end,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
    -- lsp_config.eslint.setup({
    --     capabilities = capabilities,
    --     root_dir = function()
    --         return vim.fn.getcwd()
    --     end,
    -- })
    -- lsp_config.tailwindcss.setup({
    --     capabilities = capabilities,
    --     root_dir = function()
    --         return vim.fn.getcwd()
    --     end,
    -- })
    lsp_config.gopls.setup({
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
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
