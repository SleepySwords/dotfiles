local autocmd = require('config.utils').autocmd
local lsp_status = require('lsp-status')
local lsp_installer = require("nvim-lsp-installer")
local completion_engine = require('completion.engine.cmp')
require("completion.lsp_ui_handlers")

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

autocmd("lsp_diagnostics", "CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})", true)
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
	prefix = '●', -- Could be '■', '▎', 'x'
    },
    signs = true,
    underline = true,
    update_in_insert = true,
})
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
