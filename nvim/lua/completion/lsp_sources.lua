local completion_engine = require('completion.engine.cmp')

require("mason").setup()
require("mason-lspconfig").setup()

local lsp_config = require 'lspconfig'
local lsp_status = require('lsp-status')
local navic = require("nvim-navic")
-- local lsp_inlay = require("lsp-inlayhints")
local capabilities = lsp_status.capabilities;

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}


local default_on_attach = function(client, bufnr)
	lsp_status.on_attach(client)
	navic.attach(client, bufnr)
	-- lsp_inlay.on_attach(client, bufnr)
end

lsp_config.rust_analyzer.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.lua_ls.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.omnisharp.setup(completion_engine.provide_capabilities({
	handlers = {
		["textDocument/definition"] = require('omnisharp_extended').handler,
	},
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.kotlin_language_server.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.arduino_language_server.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	cmd = {
		"arduino-language-server",
		"-cli-config", "/Users/ibrahimhizamul/Library/Arduino15/arduino-cli.yaml",
		"-fqbn", "arduino:avr:uno",
		"-cli", "arduino-cli",
		"-clangd", "clangd"
	},
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.jdtls.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.jsonls.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.volar.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.tsserver.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.pyright.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.hls.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
lsp_config.clangd.setup(completion_engine.provide_capabilities({
	capabilities = capabilities,
	on_attach = default_on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end
}))
