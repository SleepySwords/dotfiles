-- A Discord plugin RPC

if vim.g.discord then
    require("presence"):setup({
	-- General options
	auto_update         = true,
	neovim_image_text   = "The One True IDE",
	main_image          = "neovim", -- can be neovim or file

	-- Rich Presence tex options
	editing_text        = "Writing bugs in %s",
	file_explorer_text  = "Browsing %s",
	git_commit_text     = "Committing changes",
	plugin_manager_text = "Managing plugins",
	reading_text        = "Reading %s",
	workspace_text      = "Working on %s",
	line_number_text    = "Line %s out of %s"
    })
end

-- require("toggleterm").setup{}
--
-- local Terminal  = require('toggleterm.terminal').Terminal
-- local floatwindow = Terminal:new({
    -- hidden = true,
    -- -- cmd = "lazygit",
    -- direction = "float",
    -- float_opts = {
	-- border = "curved",
    -- }
-- })

function _floatwindow_toggle()
  floatwindow:toggle()
end

-- require"octo".setup()



-- Treesitter
require'nvim-treesitter.configs'.setup {
    highlight = {
	enable = true,
	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
	enable = true,
	keymaps = {
	    init_selection = "gnn",
	    node_incremental = "gnc",
	    scope_incremental = "gnrc",
	    node_decremental = "gnrm",
	},
    },
    indent = {
	enable = true
    }
}
