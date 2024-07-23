
return {
    name = "gcc build",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        local outfile = vim.fn.expand("%:p:r") .. ".out"
        return {
            cmd = { "gcc" },
            args = { file, "-o", outfile, "-g" },
            components = { { "on_output_quickfix" }, "default" },
        }
    end,
    condition = {
        filetype = { "c" },
    },
}
