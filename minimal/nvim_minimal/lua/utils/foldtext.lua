local M = {}

function M.handler(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

-- Reference: https://github.com/neovim/neovim/pull/27217#issuecomment-2631614344
local function treesitter_foldtext(lnum)
    -- Line number of first line of fold when fold is created,
    -- i.e. when `opt.foldtext` is evaluated.
    local pos = vim.v.foldstart or lnum

    -- String of first line of fold.
    local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]

    -- Get language of current buffer.
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)

    -- Create `LanguageTree`, i.e. parser object, for current buffer filetype.
    local parser = vim.treesitter.get_parser(0, lang)

    if parser == nil then
        return vim.fn.foldtext()
    end

    -- Get `highlights` query for current buffer parser, as table from file,
    -- which gives information on highlights of tree nodes produced by parser.
    local query = vim.treesitter.query.get(parser:lang(), "highlights")

    if query == nil then
        return vim.fn.foldtext()
    end

    -- Partial TSTree for buffer, including root TSNode, and TSNodes of folded line.
    -- PERF: Only parsing needed range, as parsing whole file would be slower.
    local tree = parser:parse({ pos - 1, pos })[1]

    local result = {}
    local line_pos = 0
    local prev_range = { 0, 0 }

    -- Loop through matched "captures", i.e. node-to-capture-group pairs, for each TSNode in given range.
    -- Each TSNode could occur several times in list, i.e. map to several capture groups,
    -- and each capture group could be used by several TSNodes.
    for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
        -- Name of capture group from query, for current capture.
        local name = query.captures[id]

        -- Text of captured node.
        local text = vim.treesitter.get_node_text(node, 0)
        text = text:match("^[^\n]*")

        -- Range, i.e. lines in source file, captured TSNode spans, where row is first line of fold.
        local start_row, start_col, end_row, end_col = node:range()

        -- Include part of folded line between captured TSNodes, i.e. whitespace,
        -- with arbitrary highlight group, e.g. "Folded", in final `foldtext`.
        if start_col > line_pos then
            table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
        end

        -- For control flow analysis, break if TSNode does not have proper range.
        if end_col == nil or start_col == nil then
            break
        end

        -- Move `line_pos` to end column of current node,
        -- thus ensuring next loop iteration includes whitespace between TSNodes.
        line_pos = end_col

        -- Save source code range current TSNode spans, so current TSNode can be ignored if
        -- next capture is for TSNode covering same section of source code.
        local range = { start_col, end_col }

        -- Use language specific highlight, if it exists.
        local highlight = "@" .. name
        local highlight_lang = highlight .. "." .. lang
        if vim.fn.hlexists(highlight_lang) then
            highlight = highlight_lang
        end

        -- Insert TSNode text itself, with highlight group from treesitter.
        if range[1] == prev_range[1] and range[2] == prev_range[2] then
            -- Overwrite previous capture, as it was for same range from source code.
            result[#result] = { text, highlight }
        else
            -- Insert capture for TSNode covering new range of source code.
            table.insert(result, { text, highlight })
            prev_range = range
        end
    end

    return result
end

function M.foldtext()
    local lnum = vim.v.foldstart
    local endLnum = vim.v.foldend
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local lsp_foldtext = treesitter_foldtext()
    if type(lsp_foldtext) == "table" then
        local with_suffix = vim.tbl_extend("force", {}, lsp_foldtext)
        with_suffix[0] = nil
        table.insert(with_suffix, { suffix, "MoreMsg" })
        return with_suffix
    end
    return { { lsp_foldtext, "Normal" }, { suffix, "MoreMsg" } }
end

return M
