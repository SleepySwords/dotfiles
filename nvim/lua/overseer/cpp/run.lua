return {
    name = "g++ build and run",
    builder = function()
        local outfile = vim.fn.expand("%:p:r") .. ".out"
        return {
            cmd = { outfile },
            components = {
                -- Note that since we're using the "raw task parameters" format for the dependency,
                -- we don't have to define a separate build task.
                {
                    "dependencies",
                    task_names = { "g++ build" },
                    -- { "on_output_quickfix" },
                    "default"
                },
                "default"
            }
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
