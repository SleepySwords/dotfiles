local g = vim.g

require('config.omnisharp')
require('config.dashboard-nvim')

-- A Discord plugin RPC
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


-- Tree sitter (Syntax hightlighting need 0.6 Neovim)
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}

require("toggleterm").setup{}

local Terminal  = require('toggleterm.terminal').Terminal
local floatwindow = Terminal:new({
    hidden = true,
    -- cmd = "lazygit",
    direction = "float",
    float_opts = {
	border = "curved",
    }
})

function _floatwindow_toggle()
  floatwindow:toggle()
end

