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
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('packer').init {
	max_jobs = 1
}

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
	use 'folke/tokyonight.nvim'
	use 'EdenEast/nightfox.nvim'
	use 'joshdick/onedark.vim'
	use 'rafamadriz/neon'
	use 'tanvirtin/monokai.nvim'
	use 'catppuccin/vim'

	-- Adds LSP support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	use { 'folke/neodev.nvim',
		config = function()
			require('neodev').setup()
		end
	}

	-- use 'glepnir/lspsaga.nvim'
	use {
		'RishabhRD/nvim-lsputils',
		requires = { { 'RishabhRD/popfix' } }
	}

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
	-- use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'


	use 'ray-x/lsp_signature.nvim'

	use 'onsails/lspkind.nvim'

	use 'YorickPeterse/rust.vim'
	-- use {
	-- 	'simrat39/rust-tools.nvim',
	-- 	config = function()
	-- 	end
	-- }

	--  Code snippets
	-- use 'hrsh7th/vim-vsnip'
	-- use 'hrsh7th/cmp-vsnip'
	use {
		'L3MON4D3/LuaSnip',
		config = function()
			require('completion.luasnip').setup()
		end
	}
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'

	--  Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
		config = function()
			require('navigation.telescope').setup()
		end
	}

	use 'debugloop/telescope-undo.nvim'

	-- use 'liuchengxu/vim-clap'
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'

	--  Syntax + treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('ui.treesitter')
		end,
		-- run = ':TSUpdate'
	}
	-- use 'nvim-telescope/telescope-symbols.nvim'
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
	-- use {
	-- 	'p00f/nvim-ts-rainbow',
	-- 	requires = { 'nvim-treesitter/nvim-treesitter' },
	-- }
	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		requires = { 'nvim-treesitter/nvim-treesitter' },
	}


	--  File explorer
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' }, --  for file icons
		config = function()
			require('navigation.tree').setup()
		end
	}

	-- Status line + winbar (galaxyline, lualine)
	-- TODO: need to add dependencies for this!
	use {
		'feline-nvim/feline.nvim',
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

	-- Testing
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

	-- Quality of life stuff
	use { 'windwp/nvim-autopairs',
		config = function() require('nvim-autopairs').setup {
				enable_check_bracket_line = false
			}
		end
	}

	use { 'kylechui/nvim-surround', config = function()
		require('nvim-surround').setup()
	end
	}
	use {
		'folke/twilight.nvim',
		config = function()
			require('twilight').setup()
		end
	}
	use {
		'folke/zen-mode.nvim',
		config = function()
			require('zen-mode').setup()
		end
	}
	use 'tpope/vim-commentary'
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
	use {
		'RRethy/vim-illuminate', --, conflicts with which-key
		config = function()
			require('illuminate').configure({
				providers = {
					'lsp'
				}, delay = 0
			})
		end
	}
	use {
		'lvimuser/lsp-inlayhints.nvim',
		branch = 'anticonceal',
		config = function()
			require('ui.inlay_hints').setup()
		end
	}

	use {
		'lewis6991/impatient.nvim',
		config = function()
			require('impatient').enable_profile()
		end
	}
	-- use 'vim-scripts/restore_view.vim'
	-- use 'kassio/neoterm'
	-- Why do i have lazygit if i have toggle term??!?!!
	use 'kdheepak/lazygit.nvim'
	use {
		'akinsho/toggleterm.nvim',
		config = function()
			require('toggleterm').setup()
		end
	}
	use {
		'tweekmonster/startuptime.vim',
		-- 'dstein64/vim-startuptime',
		cmd = 'StartupTime'
	}
	-- use 'norcalli/profiler.nvim'
	-- use 'github/copilot.vim'

	use {
		'nvim-orgmode/orgmode',
		config = function()
			require('orgmode').setup {}
			-- Load custom treesitter grammar for org filetype
			require('orgmode').setup_ts_grammar()

			-- Treesitter configuration
			require('nvim-treesitter.configs').setup {
				-- If TS highlights are not enabled at all, or disabled via `disable` prop,
				-- highlighting will fallback to default Vim syntax highlighting
				highlight = {
					enable = true,
					-- Required for spellcheck, some LaTex highlights and
					-- code block highlights that do not have ts grammar
					additional_vim_regex_highlighting = { 'org' },
				},
				ensure_installed = { 'org' }, -- Or run :TSUpdate org
			}
		end

	}


	-- Dashboard
	use {
		'andweeb/presence.nvim',
		cmd = 'discord'
	}
	use {
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('ui.dashboard')
		end,
		requires = { 'nvim-tree/nvim-web-devicons' }
	}

	use {
		'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async',
		config = function()
			require('ui.ufo').setup()
		end
	}

	use {
		'luukvbaal/statuscol.nvim',
		config = function()
			local builtin = require('statuscol.builtin')
			require('statuscol').setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
					{ text = { '%s' }, click = 'v:lua.ScSa' },
					{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
				},
			})
		end
	}

	use {
		'phaazon/hop.nvim',
		config = function()
			require('hop').setup()
		end
	}

	-- use {
	-- 	'ggandor/leap.nvim',
	-- 	config = function()
	-- 		require('leap').add_default_mappings()
	-- 	end
	-- }

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

	-- use {
	-- 	'glacambre/firenvim',
	-- 	run = function() vim.fn['firenvim#install'](0) end
	-- }
	--
	-- use 'lukas-reineke/indent-blankline.nvim'

	use { 'simrat39/symbols-outline.nvim', config = function() require('symbols-outline').setup() end }

	-- use 'spinks/vim-leader-guide'

	use { 'beauwilliams/focus.nvim',
		config = function() require('focus').setup({ autoresize = false, signcolumn = false }) end }

	-- Interferes with the > and < keybindings
	-- use {
	-- 	'folke/which-key.nvim',
	-- 	config = function()
	-- 		-- Cursor is really off, but oh welll
	-- 		require('which-key').setup {
	-- 			window = {
	-- 				position = 'bottom',
	-- 				-- border = 'solid',
	-- 				margin = { 1, vim.o.columns - 60, 1, 0 },
	-- 				padding = { 1, 1, 1, 1 }
	-- 			},
	-- 			triggers_blacklist = {
	-- 				n = { 'v', '>', '<' }
	-- 			},
	-- 			show_help = false,
	-- 			layout = {
	-- 				height = { min = 10, max = 15 }, -- min and max width of the columns
	-- 			},
	-- 			-- triggers = ''
	-- 		}
	-- 		require('which-key').register({
	-- 			['<Space>w'] = { name = '+LSP Workspaces' }
	-- 		})
	-- 	end
	-- } -- Lua

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
end))
