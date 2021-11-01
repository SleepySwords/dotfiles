local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require 'config.utils'
local opt = utils.opt
local autocmd = utils.autocmd
local map = utils.map

-- Omnisharp settings
g.OmniSharp_server_use_mono = 1
g.ale_linters = {cs = 'OmniSharp'}
g.asyncomplete_auto_popup = 1
g.asyncomplete_auto_completeopt = 0
g.asyncomplete_force_refresh_on_context_changed = 1
g.OmniSharp_server_stdio = 1
g.OmniSharp_highlight_types = 2
g.completion_matching_stategy_list = {'exact', 'substring', 'fuzzy'}

autocmd("omnisharp_commands", {
	"CursorHold *.cs OmniSharpTypeLookup",

	-- The following commands are contextual, based on the cursor position.
	"FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)",
	"FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)",
	"FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)",
	"FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)",
	"FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)",
	"FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)",
	"FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)",
	"FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)",
	"FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)",
	"FileType cs nmap <silent> <buffer> <C-\\> <Plug>(omnisharp_signature_help)",
	"FileType cs imap <silent> <buffer> <C-\\> <Plug>(omnisharp_signature_help)",

	-- Navigate up and down by method/property/field
	"FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)",
	"FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)",
	-- Find all code errors/warnings for the current solution and populate the quickfix window
	"FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)",
	-- Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
	"FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)",
	"FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)",
	-- Repeat the last code action performed (does not use a selector)
	"FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)",
	"FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)",

	"FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)",

	"FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)",

	"FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)",
	"FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)",
	"FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)"
}, true)

