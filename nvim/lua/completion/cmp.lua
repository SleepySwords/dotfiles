local cmp = require'cmp'

cmp.setup({
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
	{ name = 'vsnip' }, -- For vsnip users.
	-- { name = 'luasnip' }, -- For luasnip users.
	-- { name = 'ultisnips' }, -- For ultisnips users.
	-- { name = 'snippy' }, -- For snippy users.
	}, {
	    { name = 'buffer' },
    })
})

  -- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    sources = {
	{ name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
	{ name = 'path' }
    }, {
	{ name = 'cmdline' }
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
