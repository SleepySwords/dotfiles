-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
	use 'tpope/vim-sensible'

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
	-- use 'sickill/vim-monokai'
	use 'tanvirtin/monokai.nvim'
	use 'catppuccin/vim'

	-- Adds LSP support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use "williamboman/mason-lspconfig.nvim"
	use 'nvim-lua/lsp-status.nvim'
	use 'nvim-lua/lsp_extensions.nvim'

	-- use 'glepnir/lspsaga.nvim'
	use {
		'RishabhRD/nvim-lsputils',
		requires = { { 'RishabhRD/popfix' } }
	}

	-- use {
	-- "folke/trouble.nvim",
	-- requires = "kyazdani42/nvim-web-devicons",
	-- ft = "cs",
	-- config = function()
	-- require("trouble").setup {}
	-- end
	-- }

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

	use 'onsails/lspkind.nvim'

	use 'YorickPeterse/rust.vim'
	-- use {
	-- 	'simrat39/rust-tools.nvim',
	-- 	config = function()
	-- 		local rt = require("rust-tools")

	-- 		rt.setup({
	-- 			server = {
	-- 				on_attach = function(_, bufnr)
	-- 					-- Hover actions
	-- 					vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
	-- 					-- Code action groups
	-- 					vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	-- 				end,
	-- 			},
	-- 		})
	-- 	end
	-- }

	--  Code snippets
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/cmp-vsnip'
	-- use 'L3MON4D3/LuaSnip'
	-- use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'

	--  Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
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
		"SmiteshP/nvim-navic",
		requires = "nvim-treesitter/nvim-treesitter"
	}
	use {
		'nvim-treesitter/playground',
		requires = { 'nvim-treesitter/nvim-treesitter' },
	}
	use {
		'p00f/nvim-ts-rainbow',
		requires = { 'nvim-treesitter/nvim-treesitter' },
	}
	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		requires = { 'nvim-treesitter/nvim-treesitter' },
	}


	--  File explorer
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' } --  for file icons
	}

	-- Status line
	-- use {
	-- 'glepnir/galaxyline.nvim',
	-- requires = {'kyazdani42/nvim-web-devicons', opt = true}
	-- }
	-- use {
	-- 	'nvim-lualine/lualine.nvim', -- Limelight runs much faster, may consider switchign
	-- 	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	-- }
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
		},
	}
	use 'akinsho/nvim-bufferline.lua'
	-- use 'nanozuki/tabby.nvim'

	-- Buffers
	use { 'ojroques/nvim-bufdel' }

	--  Debugging
	use { 'mfussenegger/nvim-dap' }
	use { 'nvim-telescope/telescope-dap.nvim' }
	-- use {'mfussenegger/nvim-dap-python'}
	use {
		'rcarriga/nvim-dap-ui',
		config = function()
			require('dapui').setup({
				layouts = {
					{
						elements = {
							'scopes',
							'breakpoints',
							'stacks',
							'watches',
						},
						size = 40,
						position = 'left',
					},
					{
						elements = {
							'repl',
							'console',
						},
						size = 10,
						position = 'bottom',
					},
				}
			})
		end
	}
	use { 'theHamsta/nvim-dap-virtual-text' }

	use { 'mfussenegger/nvim-lint' }

	-- Testing
	-- TODO: Setup all commands
	use {
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
		config = function()
			require("neotest").setup({
				icons = {
					expanded = "",
					-- child_prefix = "",
					-- child_indent = "",
					-- final_child_prefix = "",
					-- non_collapsible = "",
					collapsed = "",

					passed = "",
					running = "",
					failed = "",
					unknown = "",
				},
				adapters = {
					-- require("neotest-python")({
					--     dap = { justMyCode = false },
					-- }),
					-- require("neotest-rust"),
					require("neotest-vim-test")({
						ignore_file_types = { "rust", "python", "vim", "lua" },
					}),
				},
			})

		end
	}

	use {
		"nvim-neotest/neotest-vim-test",
		requires = {
			"vim-test/vim-test"
		}
	}

	use 'rouge8/neotest-rust'

	-- Quality of life stuff
	-- use 'jiangmiao/auto-pairs'
	use { "windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {
				enable_check_bracket_line = false
			}
		end
	}

	-- use "steelsojka/pears.nvim"
	use { 'kylechui/nvim-surround', config = function()
		require("nvim-surround").setup({})
		-- Configuration here, or leave empty to use defaults
	end
	}
	-- use 'terrortylor/nvim-comment'
	use {
		'folke/twilight.nvim',
		config = function()
			require("twilight").setup()
		end
	}
	use {
		'folke/zen-mode.nvim',
		config = function()
			require("zen-mode").setup()
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
			require "octo".setup()
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
	use { 'lvimuser/lsp-inlayhints.nvim', config = function()
		-- require("lsp-inlayhints").setup({
		-- inlay_hints = {
		-- 	parameter_hints = {
		-- 		show = true,
		-- 		prefix = "<- ",
		-- 		separator = ", ",
		-- 		remove_colon_start = true,
		-- 		remove_colon_end = true,
		-- 	},
		-- 	type_hints = {
		-- 		-- type and other hints
		-- 		show = true,
		-- 		prefix = "",
		-- 		separator = ", ",
		-- 		remove_colon_start = true,
		-- 		remove_colon_end = true,
		-- 	},
		-- 	only_current_line = false,
		-- 	-- separator between types and parameter hints. Note that type hints are
		-- 	-- shown before parameter
		-- 	labels_separator = "  ",
		-- 	-- whether to align to the length of the longest line in the file
		-- 	max_len_align = false,
		-- 	-- padding from the left if max_len_align is true
		-- 	max_len_align_padding = 1,
		-- 	-- highlight group
		-- 	highlight = "LspInlayHint",
		-- 	-- virt_text priority
		-- 	priority = 0,
		-- },
		-- enabled_at_startup = true,
		-- debug_mode = false,
		-- })
	end }

	-- Maybe enable later?
	-- use {
	-- 	'nvim-treesitter/nvim-treesitter-context',
	-- 	config = function()
	-- 		require 'treesitter-context'.setup {
	-- 			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	-- 			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	-- 			trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	-- 			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	-- 			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
	-- 				-- For all filetypes
	-- 				-- Note that setting an entry here replaces all other patterns for this entry.
	-- 				-- By setting the 'default' entry below, you can control which nodes you want to
	-- 				-- appear in the context window.
	-- 				default = {
	-- 					'class',
	-- 					'function',
	-- 					'method',
	-- 					'for',
	-- 					'while',
	-- 					'if',
	-- 					'switch',
	-- 					'case',
	-- 				},
	-- 				-- Patterns for specific filetypes
	-- 				-- If a pattern is missing, *open a PR* so everyone can benefit.
	-- 				tex = {
	-- 					'chapter',
	-- 					'section',
	-- 					'subsection',
	-- 					'subsubsection',
	-- 				},
	-- 				rust = {
	-- 					'impl_item',
	-- 					'struct',
	-- 					'enum',
	-- 				},
	-- 				scala = {
	-- 					'object_definition',
	-- 				},
	-- 				vhdl = {
	-- 					'process_statement',
	-- 					'architecture_body',
	-- 					'entity_declaration',
	-- 				},
	-- 				markdown = {
	-- 					'section',
	-- 				},
	-- 				elixir = {
	-- 					'anonymous_function',
	-- 					'arguments',
	-- 					'block',
	-- 					'do_block',
	-- 					'list',
	-- 					'map',
	-- 					'tuple',
	-- 					'quoted_content',
	-- 				},
	-- 				json = {
	-- 					'pair',
	-- 				},
	-- 				yaml = {
	-- 					'block_mapping_pair',
	-- 				},
	-- 			},
	-- 			exact_patterns = {
	-- 				-- Example for a specific filetype with Lua patterns
	-- 				-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
	-- 				-- exactly match "impl_item" only)
	-- 				-- rust = true,
	-- 			},

	-- 			-- [!] The options below are exposed but shouldn't require your attention,
	-- 			--     you can safely ignore them.

	-- 			zindex = 20, -- The Z-index of the context window
	-- 			mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- 			-- Separator between context and content. Should be a single character string, like '-'.
	-- 			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	-- 			separator = nil,
	-- 		}
	-- 	end
	-- }
	use 'lewis6991/impatient.nvim'
	use 'vim-scripts/restore_view.vim'
	-- use 'kassio/neoterm'
	-- Why do i have lazygit if i have toggle term??!?!!
	use 'kdheepak/lazygit.nvim'
	use {
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
		end
	}
	use {
		'tweekmonster/startuptime.vim',
		-- 'dstein64/vim-startuptime',
		cmd = "StartupTime"
	}
	-- use 'norcalli/profiler.nvim'
	-- use 'github/copilot.vim'

	-- Dashboard
	use {
		'andweeb/presence.nvim',
		cmd = "discord"
	}
	use {
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require("ui.dashboard-nvim")
		end,
		requires = { 'nvim-tree/nvim-web-devicons' }
	}
	use 'samodostal/image.nvim'

	use {
		'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async'
	}

	use {
		'phaazon/hop.nvim',
		config = function()
			require('hop').setup()
		end
	}

	use {
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
		end
	}

	use({
		"folke/noice.nvim",
		config = function()
			require("ui.noice")
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		}
	})

	-- use {
	-- 	'glacambre/firenvim',
	-- 	run = function() vim.fn['firenvim#install'](0) end
	-- }
	--
	-- use 'lukas-reineke/indent-blankline.nvim'

	use { 'simrat39/symbols-outline.nvim', config = function() require("symbols-outline").setup() end }

	-- use 'spinks/vim-leader-guide'

	use { "beauwilliams/focus.nvim",
		config = function() require("focus").setup({ autoresize = false, signcolumn = false }) end }

	-- use {
	-- 	"folke/which-key.nvim",
	-- 	config = function()
	-- 		-- Cursor is really off, but oh welll
	-- 		require("which-key").setup {
	-- 			window = {
	-- 				position = 'bottom',
	-- 				-- border = "solid",
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
	-- 			-- triggers = ""
	-- 		}
	-- 		require("which-key").register({
	-- 			["<Space>w"] = { name = "+LSP Workspaces" }
	-- 		})
	-- 	end
	-- } -- Lua

	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup {}
		end
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end))
