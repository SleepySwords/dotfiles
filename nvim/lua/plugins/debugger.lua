return {
    --  Debugging
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-telescope/telescope-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            require('dbg.dap').setup()
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            "nvim-neotest/nvim-nio",
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('dbg.dap_ui').setup()
        end,
    },

    -- Add ability to debug lua plugins
    'jbyuki/one-small-step-for-vimkind',

    -- { 'mfussenegger/nvim-lint' },
}
