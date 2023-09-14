local M = {}

function M.setup()
  require('dapui').setup({
    icons = {
      expanded = '',
      current_frame = '',
      collapsed = ''
    },
    floating = {
      border = 'solid'
    },
    layouts = {
      {
        elements = {
          'scopes',
          'breakpoints',
          'stacks',
          'watches',
          'repl',
        },
        size = 40,
        position = 'left',
      },
      -- {
      --   elements = {
      --     'repl',
      --     'console',
      --   },
      --   size = 10,
      --   position = 'bottom',
      -- },
    }
  })

end

return M
