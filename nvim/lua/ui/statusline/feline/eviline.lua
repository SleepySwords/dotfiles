local line_ok, feline = pcall(require, "feline")
if not line_ok then
	return
end

local diagnostics = require('lsp-status/diagnostics')
local lsp_status = require('lsp-status')

-- TODO: This should be in it's own seperate thing rather than here.
local lsp_provider = require("feline.providers.lsp")

local navic = require("nvim-navic")

local one_monokai = {
	fg = "#abb2bf",
	bg = "#12121a",
	green = "#98c379",
	yellow = "#e5c07b",
	purple = "#c678dd",
	orange = "#d19a66",
	peanut = "#f6d5a4",
	red = "#e06c75",
	aqua = "#61afef",
	darkblue = "#1f1f26",
	dark_red = "#f75f5f",
	black = "#222222"
}

local vi_mode_colors = {
	NORMAL = "green",
	OP = "green",
	INSERT = "yellow",
	VISUAL = "purple",
	LINES = "orange",
	BLOCK = "dark_red",
	REPLACE = "red",
	COMMAND = "aqua",
}

local function get_next_colour(severity)
	-- TODO: Factorise
	local diag = diagnostics(0)
	if severity == "WARNING" then
		if diag.errors > 0 then
			return "red"
		else
			return "bg"
		end
	end
	if severity == "HINT" then
		if diag.warnings > 0 then
			return "yellow"
		elseif diag.errors > 0 then
			return "red"
		else
			return "bg"
		end
	end
	if severity == "INFO" then
		if diag.hints > 0 then
			return "green"
		elseif diag.warnings > 0 then
			return "yellow"
		elseif diag.errors > 0 then
			return "red"
		else
			return "bg"
		end
	end
	if severity == "STATUS" then
		if diag.info > 0 then
			return "aqua"
		elseif diag.hints > 0 then
			return "green"
		elseif diag.warnings > 0 then
			return "yellow"
		elseif diag.errors > 0 then
			return "red"
		else
			return "bg"
		end
	end
end

local c = {
	vim_mode = {
		provider = {
			name = "vi_mode",
			opts = {
				show_mode_name = true,
				-- padding = "center", -- Uncomment for extra padding.
			},
		},
		hl = function()
			return {
				fg = require("feline.providers.vi_mode").get_mode_color(),
				bg = "darkblue",
				-- style = "bold",
				name = "NeovimModeHLColor",
			}
		end,
		left_sep = "block",
		right_sep = "block",
	},
	navic = {
		provider = function()
			return navic.get_location()
		end,
		enabled = function()
			return navic.is_available()
		end,
		hl = {
			-- fg = "magenta",
			bg = "Normal",
		},
		-- left_sep = "block",
		-- right_sep = "block",
	},
	file = {
		provider = {
			name = 'file_info',
		},
		hl = {
			bg = "#0f0e14",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitBranch = {
		provider = "git_branch",
		hl = {
			fg = "peanut",
			bg = "darkblue",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffAdded = {
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "darkblue",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffRemoved = {
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "darkblue",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffChanged = {
		provider = "git_diff_changed",
		hl = {
			fg = "fg",
			bg = "darkblue",
		},
		left_sep = "block",
		right_sep = "right_filled",
	},
	separator = {
		provider = "",
	},
	fileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "relative-short",
			},
		},
		hl = {
			style = "bold",
		},
		left_sep = " ",
		right_sep = " ",
	},
	diagnostic_errors = {
		provider = "diagnostic_errors",
		hl = {
			fg = "bg",
			bg = 'red'
		},
		-- icon = '',
		left_sep = "slant_left",
		right_sep = "block",
		enabled = function()
			return lsp_provider.is_lsp_attached()
		end,
	},
	diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			fg = "bg",
			bg = "yellow",
		},
		left_sep = {
			str = "slant_left",
			hl = function()
				return {
					fg = "yellow",
					bg = get_next_colour("WARNING")
				}
			end
		},
		right_sep = "block",
		enabled = function()
			return lsp_provider.is_lsp_attached()
		end,
	},
	diagnostic_hints = {
		provider = "diagnostic_hints",
		hl = {
			fg = "bg",
			bg = "green",
		},
		left_sep = {
			str = "slant_left",
			hl = function()
				return {
					fg = "green",
					bg = get_next_colour("HINT")
				}
			end
		},
		right_sep = "block",
		enabled = function()
			return lsp_provider.is_lsp_attached()
		end,
	},
	diagnostic_info = {
		provider = "diagnostic_info",
		hl = {
			fg = "bg",
			bg = "aqua",
		},
		left_sep = {
			str = "slant_left",
			hl = function()
				return {
					fg = "aqua",
					bg = get_next_colour("INFO")
				}
			end
		},
		right_sep = "block",
		enabled = function()
			return lsp_provider.is_lsp_attached()
		end,
	},
	lsp_status = {
		-- Lsp status
		provider = function()
			if vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 then return '' end
			local progress = lsp_status.status_progress()
			if progress ~= '' then return progress end
			local buf_diagnostics = diagnostics(0)
			if buf_diagnostics then
				if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
					return ' ' .. vim.g.indicator_ok .. ' '
				end
				if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
					return ' ' .. vim.g.indicator_ok .. ' '
				end
				if buf_diagnostics.info and buf_diagnostics.info > 0 then
					return ' ' .. vim.g.indicator_ok .. ' '
				end
				if buf_diagnostics.hint and buf_diagnostics.hint > 0 then
					return ' ' .. vim.g.indicator_ok .. ' '
				end
			end
			return ' ' .. vim.g.indicator_ok .. ' '
		end,
		enabled = function()
			return lsp_provider.is_lsp_attached()
		end,
		hl = {
			fg = "black",
			bg = "magenta",
			style = "bold"
		},
		left_sep = {
			str = "slant_left",
			hl = function()
				return {
					fg = "magenta",
					bg = get_next_colour("STATUS")
				}
			end
		},
		right_sep = "slant_right_2",
	},
	lsp_client_names = {
		provider = "lsp_client_names",
		hl = {
			fg = "purple",
			bg = "darkblue",
			-- style = "bold",
		},
		left_sep = "left_filled",
		right_sep = "block",
	},
	file_type = {
		provider = {
			name = "file_type",
			opts = {
				filetype_icon = true,
				case = "titlecase",
			},
		},
		hl = {
			fg = "red",
			bg = "darkblue",
			-- style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	file_encoding = {
		provider = "file_encoding",
		hl = {
			fg = "orange",
			bg = "darkblue",
			style = "italic",
		},
		left_sep = "block",
		right_sep = "block",
	},
	position = {
		provider = "position",
		hl = {
			fg = "green",
			bg = "darkblue",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	line_percentage = {
		provider = "line_percentage",
		hl = {
			fg = "aqua",
			bg = "darkblue",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	-- scroll_bar = {
	-- 	provider = "scroll_bar",
	-- 	hl = {
	-- 		fg = "yellow",
	-- 		style = "bold",
	-- 	},
	-- },
}

local left = {
	c.vim_mode,
	-- c.navic,
	c.gitBranch,
	c.gitDiffAdded,
	c.gitDiffRemoved,
	c.gitDiffChanged,
	-- c.fileinfo,
	c.separator,
}

local middle = {
	c.diagnostic_errors,
	c.diagnostic_warnings,
	c.diagnostic_info,
	c.diagnostic_hints,
	c.lsp_status
}

local right = {
	c.lsp_client_names,
	c.file_type,
	c.file_encoding,
	c.position,
	c.line_percentage,
	-- c.scroll_bar,
}

local statusline_components = {
	active = {
		left,
		middle,
		right,
	},
	inactive = {
		left,
		middle,
		right,
	},
}

local winbar_component = {
	active = {
		{ c.navic },
		{ c.file }
	},
	inactive = {
		{ c.navic },
		{ c.file }
	}
}

feline.setup({
	components = statusline_components,
	theme = one_monokai,
	vi_mode_colors = vi_mode_colors,
})
feline.winbar.setup({
	components = winbar_component,
	theme = one_monokai,
	vi_mode_colors = vi_mode_colors,
})
