local completion_engine = require('completion.engine.cmp')

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    -- Default options
    local opts = {}

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(completion_engine.provide_capabilities(opts))
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Probably will remove for LSP Install
require'lspconfig'.rust_analyzer.setup(completion_engine.provide_capabilities({
    root_dir = function()
	return vim.fn.getcwd()
    end
}))