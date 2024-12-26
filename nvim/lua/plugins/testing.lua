-- Testing plugins
return {
    {
        'nvim-neotest/neotest',
        cmd = 'Neotest',
        lazy = true,
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- Might use 'mrcjkb/rustaceanvim' but have
            -- to fix showing files even when
            -- no tests (copy neotest-rust is_test_file thing)
            'rouge8/neotest-rust',
            'nvim-neotest/neotest-jest',
            'neotest-vim-test',
            'Issafalcon/neotest-dotnet',
        },
        config = function()
            ---@diagnostic disable-next-line missing-fields
            require('neotest').setup({
                icons = {
                    expanded = '',
                    collapsed = '',

                    passed = '',
                    running = '',
                    failed = '',
                    unknown = '',
                },
                consumers = {
                    overseer = require('neotest.consumers.overseer'),
                },
                overseer = {
                    enabled = true,
                    -- When this is true (the default), it will replace all neotest.run.* commands
                    force_default = true,
                },
                adapters = {
                    require('neotest-vim-test')({
                        ignore_file_types = { 'rust', 'python', 'vim', 'lua' },
                    }),
                    require('neotest-rust')({
                        dap_adapter = 'codelldb',
                    }),
                    require('neotest-dotnet'),
                    require('neotest-jest')({
                        jestCommand = 'yarn test --watch',
                        env = { CI = true },
                        cwd = function(path)
                            return vim.fn.getcwd()
                        end,
                    }),
                },
            })
        end,
    },
    {
        'nvim-neotest/neotest-vim-test',
        lazy = true,
        dependencies = {
            'vim-test/vim-test',
        },
    },
    { -- The task runner we use
        'stevearc/overseer.nvim',
        cmd = { 'OverseerRun', 'OverseerQuickAction', 'OverseerToggle' },
        opts = {
            templates = {
                'builtin',
                'cpp.build',
                'cpp.run',
                'c.run',
                'c.build',
                'haskell.runhaskell',
            },
            task_list = {
                direction = 'bottom',
                min_height = 15,
                max_height = 15,
                default_detail = 1,
            },
        },
    },
    {

        'rest-nvim/rest.nvim',
    },
    {
        'mistweaverco/kulala.nvim',
        enabled = false,
        lazy = true,
        config = function()
            require('kulala').setup({
                debug = false, -- Enable debug mode
                default_view = 'headers_body',
            })
        end,
    },
}
