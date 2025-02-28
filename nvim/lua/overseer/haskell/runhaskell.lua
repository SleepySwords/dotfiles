return {
    name = "Run haskell",
    builder = function()
        local file = vim.fn.expand("%:p")
        return {
            cmd = { "runhaskell" },
            args = { file },
        }
    end,
    condition = {
        filetype = { "haskell" },
    },
}
