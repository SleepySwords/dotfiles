local completion_engine = require('completion.engine.cmp')

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	-- Default options
	local opts = {
		capabilities = require('lsp-status').capabilities,
		on_attach = require('lsp-status').on_attach,
		root_dir = function()
			return vim.fn.getcwd()
		end
	}
	opts.capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
	}

	-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
	server:setup(completion_engine.provide_capabilities(opts))
	vim.cmd [[ do User LspAttachBuffers ]]
end)
local capabilities = require('lsp-status').capabilities;
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}
-- Probably will remove for LSP Install
require 'lspconfig'.rust_analyzer.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = function(client)
		require('lsp-status').on_attach(client)
		-- require 'illuminate'.on_attach(client)
	end,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
