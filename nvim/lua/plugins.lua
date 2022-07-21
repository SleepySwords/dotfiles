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

    --  LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
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
    --
    -- TODO: write a plugin that sends an o#/v2/gotodefinition and add handler for that. As well as changing the keybindings
    -- when entering c sharp files.
    use {
	'OmniSharp/omnisharp-vim',
	ft = 'cs'
    }
    -- use 'ms-jpq/coq_nvim'
    -- use 'ms-jpq/coq.artifacts'
    -- use 'ms-jpq/coq.thirdparty'
    use 'hrsh7th/nvim-cmp'
    -- -- CMP Sources

    use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-nvim-lsp'

    use 'onsails/lspkind.nvim'

    -- use 'rust-lang/rust.vim'
    -- use 'simrat39/rust-tools.nvim'

    --  Code snippets
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    --  Fuzzy finder
    use {
	'nvim-telescope/telescope.nvim',
	requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
    }
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
    use {
	"SmiteshP/nvim-gps",
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
    use {
	'nvim-lualine/lualine.nvim', -- Limelight runs much faster, may consider switchign
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'akinsho/nvim-bufferline.lua'

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
		require("neotest-rust"),
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
    
    -- use 'SleepySwords/neotest-rust'

    -- Quality of life stuff
    -- use 'jiangmiao/auto-pairs'
    -- use "steelsojka/pears.nvim"
    use 'tpope/vim-surround'
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
      config = function ()
	require"octo".setup()
      end
    }
    -- use 'dyng/ctrlsf.vim'
    -- use 'RRethy/vim-illuminate', conflicts with which-key
    use 'lewis6991/nvim-treesitter-context'
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
    use 'github/copilot.vim'

    -- Dashboard
    use {
	'andweeb/presence.nvim',
	cmd = "discord"
    }
    use 'glepnir/dashboard-nvim'


    use {
	'phaazon/hop.nvim',
	config = function()
	    require('hop').setup()
	end
    }

    use {
	'glacambre/firenvim',
	run = function() vim.fn['firenvim#install'](0) end
    }

    use 'simrat39/symbols-outline.nvim'

    use 'spinks/vim-leader-guide'

    use { "beauwilliams/focus.nvim", config = function () require("focus").setup({autoresize = false, signcolumn = false}) end}

    use {
	"folke/which-key.nvim",
	config = function()
	-- Cursor is really off, but oh welll
	    require("which-key").setup {
	    	window = {
	    		position = 'bottom',
	    		-- border = "solid",
	    		margin = { 1, vim.o.columns - 60, 1, 0 },
	    		padding = { 1, 1, 1, 1 }
	    	},
	    	triggers_blacklist = {
	    	    n = { 'v' }
	    	},
	    	show_help = false,
	    	layout = {
	    	    height = { min = 10, max = 15 }, -- min and max width of the columns
	    	},
		-- triggers = ""
	    }
	    require("which-key").register({
	        ["<Space>w"] = { name = "+LSP Workspaces" }
	    })
	end
    }

    if packer_bootstrap then
	require('packer').sync()
    end
end))
