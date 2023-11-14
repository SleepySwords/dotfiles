local lualine = require('lualine')
-- Color table for highlights
-- stylua: ignore
local colors = {
	bg       = '#0e101d',
	fg       = '#bbc2cf',
	yellow   = '#ECBE7B',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#98be65',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand '%:t') ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand '%:p:h'
		local gitdir = vim.fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local vim_mode = {
	-- mode component
	function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[''] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[''] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			['r?'] = colors.cyan,
			['!'] = colors.red,
			t = colors.red,
		}
		vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
		return ''
	end,
	color = 'LualineMode',
	padding = { right = 1 },
}

local file_size = {
	-- filesize component
	'filesize',
	cond = conditions.buffer_not_empty,
}

local progress = { 'progress', color = { fg = colors.fg, gui = 'bold' } }

local filename = {
	'filename',
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = 'bold' },
}

-- TODO come back to later
-- local gps = require("nvim-gps")
-- ins_left {
-- 	gps.get_location, cond = gps.is_available,
-- 	color = { fg = colors.magenta, gui = 'bold' },
-- 	icon = '> '
-- }

local lsp = {
	-- Lsp server name .
	function()
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return ''
	end,
	icon = ' :',
	color = { fg = colors.cyan, gui = 'bold' },
}

local diagnostics = require('lsp-status/diagnostics')
local lsp_status = require('lsp-status')

local lsp_status = {
	-- Lsp status
	function()
		if vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 then return '' end
		local progress = lsp_status.status_progress()
		if progress ~= '' then return progress end
		local buf_diagnostics = diagnostics(0)
		if buf_diagnostics then
			if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
				return ''
			end
			if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
				return ''
			end
			if buf_diagnostics.info and buf_diagnostics.info > 0 then
				return ''
			end
			if buf_diagnostics.hint and buf_diagnostics.hint > 0 then
				return ''
			end
		end
		return vim.g.indicator_ok
	end,
	color = { fg = colors.magenta, gui = 'bold' },
}

-- Add components to right sections
local encoing = {
	'o:encoding', -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = 'bold' },
}

local format = {
	'fileformat',
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = colors.green, gui = 'bold' },
}

local branch = {
	'branch',
	icon = '',
	color = { fg = colors.violet, gui = 'bold' },
}

local diff = {
	'diff',
	-- Is it me or the symbol for modified us really weird
	symbols = { added = ' ', modified = '柳 ', removed = ' ' },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
}

local location = { 'location' }

local left = {
	vim_mode
}

local centre = {
	vim_mode
}
local right = {
	vim_mode
}



-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = '',
		section_separators = '',
	},
	sections = {
		lualine_c = {
			'mode'
		},
	},
	inactive_sections = {},
	extensions = {
		'quickfix',
		'chadtree',
		'nvim-tree',
		'fzf',
		'toggleterm'
	}
}

-- Now don't forget to initialize lualine
lualine.setup(config)
