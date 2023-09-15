-- test
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- TODO: Explain what each plugin actually does, i s2g i don't use half of these.
require("lazy").setup({
	--  Sensible default
	-- use 'tpope/vim-sensible'

	--  Color schemes
	'sainnhe/edge',
	'morhetz/gruvbox',
	{ 'dracula/vim',   name = 'dracula' },
	{ 'sonph/onehalf', rtp = 'vim' },
	'matsuuu/pinkmare',
	'lifepillar/vim-solarized8',
	'sainnhe/sonokai',
	{
		'folke/tokyonight.nvim',
		config = function()
			require('theme.tokyonight').setup()
		end
	},
	'EdenEast/nightfox.nvim',
	'joshdick/onedark.vim',
	'rafamadriz/neon',
	'tanvirtin/monokai.nvim',
	'catppuccin/vim',

	-- Adds LSP support
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('completion.lsp')
		end
	},
	'williamboman/mason.nvim',
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim'
		},
		config = function()
			require('completion.mason').setup()
		end
	},

	-- Hopefully easier to customise colours
	'tjdevries/colorbuddy.nvim',

	-- Adds neovim docs to lsp
	{
		'folke/neodev.nvim',
		config = function()
			require('neodev').setup()
		end
	},

	-- Adds better defaults for LSP
	{
		'RishabhRD/nvim-lsputils',
		dependencies = {
			'RishabhRD/popfix',
			'neovim/nvim-lspconfig'
		},
		config = function()
			require('completion.lsp_utils').setup()
		end
	},

	-- Improves the vim.ui stuff, such as vim.ui.input() (gr)
	{
		'stevearc/dressing.nvim',
		dependencies = {
			-- 'nvim-telescope/telescope.nvim'
		},
		config = function()
			require('ui.dressing').setup()
		end
	},

	-- Adds trouble which displays references, diagnostics
	{
		'folke/trouble.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		-- ft = 'cs',
		config = function()
			require('trouble').setup {
				action_keys = {
					jump = { '<tab>' },
					jump_close = { 'o', '<cr>' },
				}
			}
		end
	},

	-- Unfortunately the way decompilation works in omnisharp is that the client sends a
	-- o#/v2/gotodefinition request, which returns with a metadata source field, that is used
	-- in a o#/metadata request to get the decompilation. Unfortunately, LSP in neovim sends a
	-- textDocument/definition request, which doesn't return the metadata source, so either send another
	-- o#/v2/gotodefinition when recieving the textDocument/definition request or send a o#/v2/gotodefinition
	-- from the start, which is what is happening here with this plugin. Need to keep in mind that this uses
	-- two instances of omnisharp as a result.
	'Hoffs/omnisharp-extended-lsp.nvim',

	-- Autocompletion
	'hrsh7th/nvim-cmp',

	-- Autocomplete Sources
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp',

	-- Displays the function signature and current field.
	-- Keybind: <leader>k
	'ray-x/lsp_signature.nvim',

	-- Adds icons to lsp variables
	'onsails/lspkind.nvim',

	--  Code snippets support
	{
		'L3MON4D3/LuaSnip',
		config = function()
			require('completion.luasnip').setup()
		end
	},
	'saadparwaiz1/cmp_luasnip',
	'rafamadriz/friendly-snippets',

	--  Fuzzy finders
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
		config = function()
			require('navigation.telescope').setup()
		end
	},
	'debugloop/telescope-undo.nvim',
	'junegunn/fzf',
	'junegunn/fzf.vim',

	--  Syntax + treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('ui.treesitter')
			require('plg.headlines').setup()
		end,
		run = ':TSUpdate'
	},
	{
		'SmiteshP/nvim-navic',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		config = function()
			require('ui.navic').setup()
		end
	},
	{
		'HiPhish/rainbow-delimiters.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},

	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		after = "nvim-treesitter"
	},

	{
		'ziontee113/syntax-tree-surfer',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('ui.treesurfer').setup()
		end
	},


	--  File explorer
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' }, --  for file icons
		config = function()
			require('navigation.tree').setup()
		end
	},

	-- Statusline + winbar (galaxyline, lualine) + bufferline
	{
		'freddiehaddad/feline.nvim',
		dependencies = {
			{
				'lewis6991/gitsigns.nvim',
				dependencies = { 'nvim-lua/plenary.nvim' },
				config = function()
					require('gitsigns').setup()
				end,
			},
			'nvim-tree/nvim-web-devicons',
			'SmiteshP/nvim-navic',
			'nvim-lua/lsp-status.nvim',
		},
		config = function()
			require('ui.statusline.feline.eviline')
		end
	},
	{
		'akinsho/nvim-bufferline.lua',
		config = function()
			require('ui.bufferline').setup()
		end
	},
	{
		'nvim-lua/lsp-status.nvim',
		config = function()
			require('ui.lsp_status').setup()
		end
	},

	-- Buffers
	{ 'ojroques/nvim-bufdel' },

	--  Debugging
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'nvim-telescope/telescope-dap.nvim',
			'theHamsta/nvim-dap-virtual-text'
		},
		config = function()
			require('dbg.dap').setup()
		end
	},
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap'
		},
		config = function()
			require('dbg.dap_ui').setup()
		end
	},
	-- Add ability to debug lua plugins
	'jbyuki/one-small-step-for-vimkind',

	{ 'mfussenegger/nvim-lint' },

	-- Testing plugins
	-- TODO: Setup all commands
	{
		'nvim-neotest/neotest',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
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
	},
	{
		'nvim-neotest/neotest-vim-test',
		dependencies = {
			'vim-test/vim-test'
		}
	},
	'rouge8/neotest-rust',

	--- Quality of life stuff
	-- auto add the ending bracket
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup {
				enable_check_bracket_line = false
			}
		end
	},

	-- Surround commands (ysiw')
	-- Keybinds: ys, ds, cs,
	{
		'kylechui/nvim-surround',
		config = function()
			require('nvim-surround').setup()
		end
	},

	-- Highlight only the code section you are editing
	{
		'folke/twilight.nvim',
		config = function()
			require('twilight').setup()
		end
	},

	-- Enter :ZenMode
	{
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
	},

	-- Able to comment stuff out, gcc
	'tpope/vim-commentary',

	-- Git integration
	{
		'pwntester/octo.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- 'nvim-telescope/telescope.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require 'octo'.setup()
		end
	},

	-- use 'dyng/ctrlsf.vim'

	-- Highlight variables with the same name.
	{
		'RRethy/vim-illuminate', --, conflicts with which-key
		config = function()
			require('illuminate').configure({
				providers = {
					'lsp'
				},
				delay = 0
			})
		end
	},

	-- use 'vim-scripts/restore_view.vim'
	-- use 'kassio/neoterm'
	-- Why do i have lazygit if i have toggle term??!?!!
	'kdheepak/lazygit.nvim',
	{
		'akinsho/toggleterm.nvim',
		config = function()
			require('ui.toggleterm_ui').setup()
		end
	},
	{
		'tweekmonster/startuptime.vim',
		-- 'dstein64/vim-startuptime',
		cmd = 'StartupTime'
	},
	-- use 'norcalli/profiler.nvim'
	-- use 'github/copilot.vim'

	-- Discord rich presence
	{
		'andweeb/presence.nvim',
	},

	-- Adds dashboard
	{
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('ui.dashboard')
		end,
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},

	-- Adds folds for lsp, treesitter, mainly functions
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		config = function()
			require('ui.ufo').setup()
		end
	},

	-- Adds statuscol plugin, allows for the down arrow folds.
	{
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
	},

	{
		'folke/flash.nvim',
		event = "VeryLazy",
		config = function()
			vim.api.nvim_set_hl(0, 'FlashLabel', { bold = true, ctermfg = 45, fg = "#ff007c" })
			vim.api.nvim_set_hl(0, 'FlashKey1', { bold = true, ctermfg = 45, fg = "#00dfff" })
			vim.api.nvim_set_hl(0, 'FlashKey2', { bold = true, ctermfg = 45, fg = "#2b8db3" })
			require "flash".setup({
				label = {
					-- style = "inline"
					-- rainbow = {
					-- 	enabled = true
					-- }
				},
				modes = {
					char = {
						highlight = {
							backdrop = false
						}
					}
				}
			})
		end,
		keys = {
			{
				"s",
				mode = { "n", "o", "x" },
				function()
					require("flash").jump()
				end,
				desc = "Flash"
			},
			{
				"<leader>j",
				mode = { "n", "o", "x" },
				function()
					local Flash = require("flash")

					---@param opts Flash.Format
					local function format_first_lbl(opts)
						-- always show first and second label
						return {
							{ opts.match.label1, "FlashKey1" },
							{ opts.match.label2, "FlashKey2" },
						}
					end

					---@param opts Flash.Format
					local function format_second_lbl(opts)
						-- always show only second
						return {
							{ opts.match.label2, "FlashLabel" },
						}
					end

					Flash.jump({
						search = { mode = "search" },
						label = {
							after = false,
							before = { 0, 0 },
							uppercase = false,
							format = format_first_lbl
						},
						pattern = [[\<]],
						action = function(match, state)
							state:hide()
							Flash.jump({
								search = { max_length = 0 },
								highlight = { matches = false },
								label = { format = format_second_lbl },
								matcher = function(win)
									-- limit matches to the current label
									return vim.tbl_filter(function(m)
										return m.label == match.label and
										    m.win == win
									end, state.results)
								end,
								labeler = function(matches)
									for _, m in ipairs(matches) do
										m.label = m
										    .label2 -- use the second label
									end
								end,
							})
						end,
						labeler = function(matches, state)
							local labels = state:labels()
							for m, match in ipairs(matches) do
								match.label1 = labels[math.floor((m - 1) / #labels) + 1]
								match.label2 = labels[(m - 1) % #labels + 1]
								match.label = match.label1
							end
						end,
					})
				end,
				desc = "Hop/Easymotion"
			},
		},
	},

	{
		'folke/noice.nvim',
		config = function()
			require('ui.noice')
		end,
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	},

	-- Adds :SymbolsOutline
	{ 'simrat39/symbols-outline.nvim', config = function() require('symbols-outline').setup() end },

	-- TODO: investigate why i have this
	-- use { 'beauwilliams/focus.nvim',
	-- 	config = function() require('focus').setup({ autoresize = false, signcolumn = false }) end }

	-- Interferes with the > and < keybindings

	-- Displays the key that is present.
	{
		'folke/which-key.nvim',
		config = function()
			require('ui.which_key').setup()
		end
	},

	-- Highlights comments that are marked todo, fix, etc..
	{
		'folke/todo-comments.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		config = function()
			require('todo-comments').setup {}
		end
	},

	'gpanders/editorconfig.nvim',

	-- Could just use ftplugins instead /shrug
	'tpope/vim-sleuth',

	-- Markdown
	-- Literally copy and pasted this :)
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

	{
		'nvim-neorg/neorg',
		run = ":Neorg sync-parsers", -- This is the important bit!
		config = function()
			require('config.neorg').setup()
		end,
	},
})


-- Plugins that need to try again
-- Satellite.nvim (scrollbar)
-- Wilder.nvim (cmdline popup menu)
-- firenvim (in browser)
-- lukas-reineke/indent-blankline.nvim (add ident lines)
-- edgy.nvim
-- Leap.nvim
-- Harpoon
-- LspSaga
