local M = {}

function M.setup()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        work = "~/notes/work",
                        home = "~/notes/home",
                    }
                }
            },
            ["core.concealer"] = {},
            -- ["core.completion"] = {},
            -- ["core.export.markdown "] = {},
            ["core.export"] = {}
        }
    }
end

return M
