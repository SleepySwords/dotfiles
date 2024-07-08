local cmp = require('cmp')
local types = require('cmp.types')

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local luasnip = require('luasnip')

cmp.setup({
    window = {
        completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        expandable_indicator = false,
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            local menu_item = vim_item.kind
            local kind = require('lspkind').cmp_format({
                mode = 'symbol',
                preset = 'default',
                maxwidth = 50,
            })(entry, vim_item)
            kind.kind = ' ' .. kind.kind .. ' '
            kind.menu = '    ' .. menu_item

            return kind
        end,
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            -- if cmp.visible() then
            -- 	cmp.select_next_item()
            -- if vim.fn["vsnip#available"](1) == 1 then
            -- 	feedkey("<Plug>(vsnip-expand-or-jump)", "")
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
                -- elseif has_words_before() then
                --   cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            -- if cmp.visible() then
            -- 	cmp.select_prev_item()
            -- if vim.fn["vsnip#jumpable"](-1) == 1 then
            -- 	feedkey("<Plug>(vsnip-jump-prev)", "")
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { 'i', 's' }),

        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end),

        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    experimental = {
        -- native_menu = false,
        ghost_text = true,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'orgmode' },
        { name = 'luasnip' },
        { name = 'path' },
        -- { name = 'buffer' },
        -- { name = 'cmdline' }
    }),
})

-- cmp.setup.cmdline(':', {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources({
-- 		{ name = 'path' }
-- 	}, {
-- 		{
-- 			name = 'cmdline',
-- 			option = {
-- 				ignore_cmds = { 'Man', '!' }
-- 			}
-- 		}
-- 	})
-- })

-- cmp.setup.cmdline('/', {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		{ name = 'buffer' }
-- 	}
-- })

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local provide_capabilities = function(opts)
    opts.capabilities =
        vim.tbl_extend('keep', cmp_nvim_lsp.default_capabilities(), opts.capabilities)
    return opts
end

local highlights = {
    PmenuSel = { bg = '#282C34', fg = 'NONE' },
    Pmenu = { link = 'NormalFloat' },

    CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
    CmpItemAbbrMatch = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemAbbrMatchFuzzy = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },

    -- CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
    -- CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
    -- CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

    -- CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
    -- CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
    -- CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

    -- CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
    -- CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
    -- CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

    -- CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
    -- CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
    -- CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
    -- CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
    -- CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

    -- CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
    -- CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

    -- CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
    -- CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
    -- CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

    -- CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
    -- CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
    -- CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

    -- CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
    -- CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
    CmpItemKindTypeParameter = { fg = '#D8EEEB', bg = '#58B5A8' },
}

for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, v)
end

return { provide_capabilities = provide_capabilities }
