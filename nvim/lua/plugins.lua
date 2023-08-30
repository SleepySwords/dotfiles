-- test
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	vim.g.bootstrap = true
	local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
	if not string.find(vim.o.runtimepath, rtp_addition) then
		vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
	end
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path })
end

require('packer').init({
	max_jobs = 60
})

-- TODO: Explain what each plugin actually does, i s2g i don't use half of these.
return require('packer').startup((function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	--  Sensible default
	-- use 'tpope/vim-sensible'

	--  Color schemes
	use 'sainnhe/edge'
	use 'morhetz/gruvbox'
	use { 'dracula/vim', as = 'dracula' }
	use { 'sonph/onehalf', rtp = 'vim' }
	use 'matsuuu/pinkmare'
	use 'lifepillar/vim-solarized8'
	use 'sainnhe/sonokai'
	use {
		'folke/tokyonight.nvim',
		config = function()
			require('theme.tokyonight').setup()
		end
	}
	use 'EdenEast/nightfox.nvim'
	use 'joshdick/onedark.vim'
	use 'rafamadriz/neon'
	use 'tanvirtin/monokai.nvim'
	use 'catppuccin/vim'

	-- Adds LSP support
	use {
		'neovim/nvim-lspconfig',
		config = function()
			require('completion.lsp')
		end
	}
	use 'williamboman/mason.nvim'
	use {
		'williamboman/mason-lspconfig.nvim',
		requires = {
			'williamboman/mason.nvim'
		},
		config = function()
			require('completion.mason').setup()
		end
	}

	-- Adds neovim docs to lsp
	use { 'folke/neodev.nvim',
		config = function()
			require('neodev').setup()
		end
	}

	-- Adds better defaults for LSP
	use {
		'RishabhRD/nvim-lsputils',
		requires = {
			'RishabhRD/popfix',
			'neovim/nvim-lspconfig'
		},
		config = function()
			require('completion.lsp_utils').setup()
		end
	}

	-- Improves the vim.ui stuff, such as vim.ui.input() (gr)
	use { 'stevearc/dressing.nvim',
		requires = {
			'nvim-telescope/telescope.nvim'
		},
		config = function()
			require('ui.dressing').setup()
		end
	}

	-- Adds trouble which displays references, diagnostics
	use {
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		-- ft = 'cs',
		config = function()
			require('trouble').setup {
				action_keys = {
					jump = { '<tab>' },
					jump_close = { 'o', '<cr>' },
				}
			}
		end
	}

	-- Unfortunately the way decompilation works in omnisharp is that the client sends a
	-- o#/v2/gotodefinition request, which returns with a metadata source field, that is used
	-- in a o#/metadata request to get the decompilation. Unfortunately, LSP in neovim sends a
	-- textDocument/definition request, which doesn't return the metadata source, so either send another
	-- o#/v2/gotodefinition when recieving the textDocument/definition request or send a o#/v2/gotodefinition
	-- from the start, which is what is happening here with this plugin. Need to keep in mind that this uses
	-- two instances of omnisharp as a result.
	use 'Hoffs/omnisharp-extended-lsp.nvim'

	-- Autocompletion
	use 'hrsh7th/nvim-cmp'

	-- Autocomplete Sources
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'

	-- Displays the function signature and current field.
	-- Keybind: <leader>k
	use 'ray-x/lsp_signature.nvim'

	-- Adds icons to lsp variables
	use 'onsails/lspkind.nvim'

	--  Code snippets support
	use {
		'L3MON4D3/LuaSnip',
		config = function()
			require('completion.luasnip').setup()
		end
	}
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'

	--  Fuzzy finders
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
		config = function()
			require('navigation.telescope').setup()
		end
	}
	use 'debugloop/telescope-undo.nvim'
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'

	--  Syntax + treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('ui.treesitter')
			require('plg.headlines').setup()
		end,
		run = ':TSUpdate'
	}
	use {
		'SmiteshP/nvim-navic',
		requires = 'nvim-treesitter/nvim-treesitter',
		config = function()
			require('ui.navic').setup()
		end
	}
	use {
		'nvim-treesitter/playground',
		requires = { 'nvim-treesitter/nvim-treesitter' },
	}

	use {
		'HiPhish/nvim-ts-rainbow2',
		requires = { 'nvim-treesitter/nvim-treesitter' },
	}

	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		after = "nvim-treesitter"
	}

	use {
		'ziontee113/syntax-tree-surfer',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('ui.treesurfer').setup()
		end
	}


	--  File explorer
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' }, --  for file icons
		config = function()
			require('navigation.tree').setup()
		end
	}

	-- Statusline + winbar (galaxyline, lualine) + bufferline
	use {
		'freddiehaddad/feline.nvim',
		requires = {
			{
				'lewis6991/gitsigns.nvim',
				requires = { 'nvim-lua/plenary.nvim' },
				config = function()
					require('gitsigns').setup()
				end,
			},
			'kyazdani42/nvim-web-devicons',
			'SmiteshP/nvim-navic',
			'nvim-lua/lsp-status.nvim',
		},
		config = function()
			require('ui.statusline.feline.eviline')
		end
	}
	use {
		'akinsho/nvim-bufferline.lua',
		config = function()
			require('ui.bufferline').setup()
		end
	}
	use {
		'nvim-lua/lsp-status.nvim',
		config = function()
			require('ui.lsp_status').setup()
		end
	}

	-- Buffers
	use { 'ojroques/nvim-bufdel' }

	--  Debugging
	use {
		'mfussenegger/nvim-dap',
		requires = {
			'nvim-telescope/telescope-dap.nvim',
			'theHamsta/nvim-dap-virtual-text'
		},
		config = function()
			require('dbg.dap').setup()
		end
	}
	use {
		'rcarriga/nvim-dap-ui',
		requires = {
			'mfussenegger/nvim-dap'
		},
		config = function()
			require('dbg.dap_ui').setup()
		end
	}

	use { 'mfussenegger/nvim-lint' }

	-- Testing plugins
	-- TODO: Setup all commands
	use {
		'nvim-neotest/neotest',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'antoinemadec/FixCursorHold.nvim',
		},
		config = function()
			require('neotest').setup({
				icons = {
					expanded = '',
					collapsed = '',

					passed = '',
					running = '',
					failed = '',
					unknown = '',
				},
				adapters = {
					require('neotest-vim-test')({
						ignore_file_types = { 'rust', 'python', 'vim', 'lua' },
					}),
				},
			})
		end
	}
	use {
		'nvim-neotest/neotest-vim-test',
		requires = {
			'vim-test/vim-test'
		}
	}
	use 'rouge8/neotest-rust'

	--- Quality of life stuff
	-- auto add the ending bracket
	use { 'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup {
				enable_check_bracket_line = false
			}
		end
	}

	-- Surround commands (ysiw')
	-- Keybinds: ys, ds, cs,
	use { 'kylechui/nvim-surround', config = function()
		require('nvim-surround').setup()
	end
	}

	-- Highlight only the code section you are editing
	use {
		'folke/twilight.nvim',
		config = function()
			require('twilight').setup()
		end
	}

	-- Enter :ZenMode
	use {
		'folke/zen-mode.nvim',
		config = function()
			require('zen-mode').setup {
				window = {
					backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					-- height and width can be:
					-- * an absolute number of cells when > 1
					-- * a percentage of the width / height of the editor when <= 1
					-- * a function that returns the width or the height
					width = 100, -- width of the Zen window
					height = 1, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						signcolumn = "no", -- disable signcolumn
						number = false, -- disable number column
						relativenumber = false, -- disable relative numbers
						cursorline = false, -- disable cursorline
						cursorcolumn = false, -- disable cursor column
						foldcolumn = "0", -- disable fold column
						list = false, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					-- comment the lines to not apply the options
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
					},
					twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
					gitsigns = { enabled = false }, -- disables git signs_staged
				}
			}
		end
	}

	-- Able to comment stuff out, gcc
	use 'tpope/vim-commentary'

	-- Git integration
	use {
		'pwntester/octo.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require 'octo'.setup()
		end
	}

	-- use 'dyng/ctrlsf.vim'

	-- Highlight variables with the same name.
	use {
		'RRethy/vim-illuminate', --, conflicts with which-key
		config = function()
			require('illuminate').configure({
				providers = {
					'lsp'
				},
				delay = 0
			})
		end
	}

	-- use 'vim-scripts/restore_view.vim'
	-- use 'kassio/neoterm'
	-- Why do i have lazygit if i have toggle term??!?!!
	use 'kdheepak/lazygit.nvim'
	use {
		'akinsho/toggleterm.nvim',
		config = function()
			require('ui.toggleterm_ui').setup()
		end
	}
	use {
		'tweekmonster/startuptime.vim',
		-- 'dstein64/vim-startuptime',
		cmd = 'StartupTime'
	}
	-- use 'norcalli/profiler.nvim'
	-- use 'github/copilot.vim'

	-- Discord rich presence
	use {
		'andweeb/presence.nvim',
		cmd = 'discord'
	}

	-- Adds dashboard
	use {
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('ui.dashboard')
		end,
		requires = { 'nvim-tree/nvim-web-devicons' }
	}

	-- Adds folds for lsp, treesitter, mainly functions
	use {
		'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async',
		config = function()
			require('ui.ufo').setup()
		end
	}

	-- Adds statuscol plugin, allows for the down arrow folds.
	use {
		'luukvbaal/statuscol.nvim',
		config = function()
			local builtin = require('statuscol.builtin')
			require('statuscol').setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
					{ text = { '%s' },                  click = 'v:lua.ScSa' },
					{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
				},
			})
		end
	}

	-- Add easier navigation <leader>j
	use {
		'phaazon/hop.nvim',
		config = function()
			require('hop').setup()
		end
	}

	use({
		'folke/noice.nvim',
		config = function()
			require('ui.noice')
		end,
		requires = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	})

	-- Adds :SymbolsOutline
	use { 'simrat39/symbols-outline.nvim', config = function() require('symbols-outline').setup() end }

	-- TODO: investigate why i have this
	-- use { 'beauwilliams/focus.nvim',
	-- 	config = function() require('focus').setup({ autoresize = false, signcolumn = false }) end }

	-- Interferes with the > and < keybindings

	-- Displays the key that is present.
	use {
		'folke/which-key.nvim',
		config = function()
			require('ui.which_key').setup()
		end
	}

	-- Highlights comments that are marked todo, fix, etc..
	use {
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('todo-comments').setup {}
		end
	}

	use 'gpanders/editorconfig.nvim'

	-- Could just use ftplugins instead /shrug
	use 'tpope/vim-sleuth'

	if packer_bootstrap then
		require('packer').sync()
	end


	-- Markdown
	-- use {
	-- 	'lukas-reineke/headlines.nvim',
	-- 	after = 'nvim-treesitter',
	-- 	config = function()
	-- 		require('headlines').setup {
	-- 			markdown = {
	-- 				dash_string = "•",

	-- 			}
	-- 		}
	-- 	end,
	-- }

	use {
		'nvim-neorg/neorg',
		run = ":Neorg sync-parsers", -- This is the important bit!
		config = function()
			require('config.neorg').setup()
		end,
	}
end))


-- Plugins that need to try again
-- Satellite.nvim (scrollbar)
-- Wilder.nvim (cmdline popup menu)
-- firenvim (in browser)
-- lukas-reineke/indent-blankline.nvim (add ident lines)
-- edgy.nvim
-- Leap.nvim
-- Harpoon
-- LspSaga
