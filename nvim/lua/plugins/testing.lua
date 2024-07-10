-- Testing plugins
return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            "nvim-neotest/nvim-nio",
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
                adapters = {
                    require('neotest-vim-test')({
                        ignore_file_types = { 'rust', 'python', 'vim', 'lua' },
                    }),
                    require('neotest-rust') {
                        dap_adapter = "codelldb",
                    },
                    require("neotest-dotnet"),
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
        dependencies = {
            'vim-test/vim-test',
        },
    },
    { -- This plugin
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
        opts = {},
    },
    { -- The task runner we use
        "stevearc/overseer.nvim",
        commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 15,
                max_height = 15,
                default_detail = 1
            },
        },
    },
}
