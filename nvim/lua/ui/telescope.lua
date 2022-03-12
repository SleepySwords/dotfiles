local telescope = {}

function telescope.get_theme(opts)
  opts = opts or {}

  local theme_opts = {
    theme = "custom",

    sorting_strategy = "ascending",

    layout_strategy = "horizontal",
    layout_config = {
      height = 25,
    },

    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  }
  if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
    theme_opts.borderchars = {
      prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
      results = { "─", " ", " ", " ", "─", "─", " ", " " },
      preview = { "─", " ", "─", "│", "┬", "─", "─", "╰" },
    }
  end

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

return telescope
