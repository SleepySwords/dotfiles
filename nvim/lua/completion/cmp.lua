local cmp = require'cmp'
local types = require('cmp.types')

cmp.setup({
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			function(entry1, entry2)
				local kind1 = entry1:get_kind()
				kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
				local kind2 = entry2:get_kind()
				kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
				if kind1 ~= kind2 then
					-- Removes Snippet priority
					-- if kind1 == types.lsp.CompletionItemKind.Snippet then
					-- 	return true
					-- end
					-- if kind2 == types.lsp.CompletionItemKind.Snippet then
					-- 	return false
					-- end
					local diff = kind1 - kind2
					if diff < 0 then
						return true
					elseif diff > 0 then
						return false
					end
				end
			end,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
    },
    snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
		    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		    -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		end,
    },
    mapping = {
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
		['<C-e>'] = cmp.mapping({
		    i = cmp.mapping.abort(),
		    c = cmp.mapping.close(),
		}),
		['<S-Tab>'] = function(fallback)
		    if cmp.visible() then
			cmp.select_prev_item()
		    else
			fallback()
		    end
		end,
		['<Tab>'] = function(fallback)
		    if cmp.visible() then
			cmp.select_next_item()
		    else
			fallback()
		    end
		end,
		['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	    { name = 'buffer' },
		{ name = 'path' },
		{ name = 'cmdline' }
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	})
})


local completion = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

completion.provide_capabilities = function(opts)
	opts.capabilities = capabilities
	return opts
end

return completion
