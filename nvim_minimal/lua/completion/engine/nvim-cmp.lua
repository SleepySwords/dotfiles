local cmp = require('cmp')
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
            kind.menu = '    ' .. (menu_item or '')

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
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { 'i', 's' }),

        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
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
        {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
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
