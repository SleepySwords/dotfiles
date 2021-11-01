local lsp_status = require('lsp-status')
local lsp_installer = require("nvim-lsp-installer")
local completion_engine = require('completion.cmp')

-- require('completion.rust-tools')
require('lsp_extensions').inlay_hints()

-- use properly: https://github.com/nvim-lua/lsp-status.nvim
lsp_status.register_progress()

lsp_installer.on_server_ready(function(server)
    -- Default options
    local opts = {}

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(completion_engine.provide_capabilities(opts))
    vim.cmd [[ do User LspAttachBuffers ]]
end)
