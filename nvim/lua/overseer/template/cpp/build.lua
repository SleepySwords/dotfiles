return {
    name = "g++ build",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        local outfile = vim.fn.expand("%:p:r") .. ".out"
        return {
            cmd = { "g++" },
            args = { file, "-o", outfile },
            components = { { "on_output_quickfix" }, "default" },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
