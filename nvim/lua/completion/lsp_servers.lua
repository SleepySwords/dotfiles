local lsp_config = require("lspconfig")

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
    vim.lsp.enable('rust_analyzer')
    vim.lsp.config('*', {
        capabilities = capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end
    })
    vim.lsp.config('rust_analyzer', {
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
    vim.lsp.enable('lua_ls')
    lsp_config.lua_ls.setup({
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              'lua/?.lua',
              'lua/?/init.lua',
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            }
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    })
    vim.lsp.enable('kotlin_language_server')
    vim.lsp.enable('arduino_language_server')
    vim.lsp.config('arduino_language_server', {
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
    })
    vim.lsp.enable('jdtls')
    vim.lsp.enable('jsonls')
    vim.lsp.enable('vue_ls')
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('pyright')
    vim.lsp.enable('hls')
    vim.lsp.config('hls', {
        settings = {
            haskell = {
                plugin = {
                    rename = { config = { crossModule = true } },
                },
            },
        },
    })
    vim.lsp.enable('clangd')
    vim.lsp.enable('wgsl_analyzer')
    vim.lsp.enable('zls')
    -- lsp_config.biome.setup({
    -- 	capabilities = capabilities,
    -- 	root_dir = function()
    -- 		return vim.fn.getcwd()
    -- 	end
    -- })

    vim.lsp.enable('marksman')
    vim.lsp.enable('texlab')
    vim.lsp.enable('java_language_server')
    vim.lsp.config('java_language_server', {
        capabilities = capabilities,
        cmd = function()
            vim.fn.expand('$HOME/lsp/java-langauge-server')
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
    vim.lsp.enable('gopls')
    vim.lsp.enable('ocamllsp')
    vim.lsp.enable('terraformls')
end

-- This is a special case, as omnisharp needs extended.
function M.setup_omni()
    vim.lsp.enable('omnisharp')
    vim.lsp.config('omnisharp', {
        handlers = {
            ['textDocument/definition'] = require('omnisharp_extended').handler,
        },
        cmd = { vim.env.HOME .. '/.local/share/nvim/mason/packages/omnisharp/omnisharp' },
        root_dir = function()
            return vim.fn.getcwd()
        end,
    })
end

return M
