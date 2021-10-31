local lsp_status = require('lsp-status')
local lsp_installer = require("nvim-lsp-installer")
local completion_engine = require('completion.cmp')


lsp_status.register_progress()

lsp_installer.on_server_ready(function(server)
    local opts = {}
    -- May cause problems with finding methods
    -- opts.capabilities = capable

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(completion_engine.provide_capabilities(opts))
    vim.cmd [[ do User LspAttachBuffers ]]
end)
