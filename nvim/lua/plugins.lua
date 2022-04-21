-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    vim.g.bootstrap = true
    local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
    if not string.find(vim.o.runtimepath, rtp_addition) then
	vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
    end
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --  Sensible default
    use 'tpope/vim-sensible'

    --  Color schemes
    use 'sainnhe/edge'
    use 'morhetz/gruvbox'
    use {'dracula/vim', as = 'dracula'}
    use {'sonph/onehalf', rtp = 'vim'}
    use 'matsuuu/pinkmare'
    use 'lifepillar/vim-solarized8'
    use 'sainnhe/sonokai'
    use 'folke/tokyonight.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'joshdick/onedark.vim'
    -- use 'sickill/vim-monokai'

    --  LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/lsp_extensions.nvim'

    -- use 'glepnir/lspsaga.nvim'
    use {
	'RishabhRD/nvim-lsputils',
	requires= {{'RishabhRD/popfix'}}
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
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-nvim-lsp'

    -- use 'rust-lang/rust.vim'
    -- use 'simrat39/rust-tools.nvim'

    --  Code snippets
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    --  Fuzzy finder
    use {
	'nvim-telescope/telescope.nvim',
	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    -- use 'liuchengxu/vim-clap'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'

    --  Syntax
    use {
	'nvim-treesitter/nvim-treesitter',
	config = function()
	    require('ui.treesitter')
	end,
	-- run = ':TSUpdate'
    }
    use {
	'nvim-treesitter/playground',
	requires = {'nvim-treesitter/nvim-treesitter'},
    }

    --  File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}  --  for file icons
    }

    -- Status line
    -- use {
	-- 'glepnir/galaxyline.nvim',
	-- requires = {'kyazdani42/nvim-web-devicons', opt = true}
    -- }
    use {
	'nvim-lualine/lualine.nvim', -- Limelight runs much faster, may consider switchign
	requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'akinsho/nvim-bufferline.lua'

    -- Buffers
    use {'ojroques/nvim-bufdel'}

    --  Debugging
    use {'mfussenegger/nvim-dap'}
    use {'nvim-telescope/telescope-dap.nvim'}
    -- use {'mfussenegger/nvim-dap-python'}
    use {
	'rcarriga/nvim-dap-ui',
	config = function()
	    require("dapui").setup {
		sidebar = {
		    position = "right"
		}
	    }
	end
    }
    use {'theHamsta/nvim-dap-virtual-text'}

    -- Testing
    -- TODO: Setup all commands
    use {
        "rcarriga/vim-ultest",
        config = "require('config.ultest').post()",
        run = ":UpdateRemotePlugins",
        requires = {"vim-test/vim-test"},
	cmd = "ultest"
    }

    -- Quality of life stuff
    use 'jiangmiao/auto-pairs'
    -- use 'terrortylor/nvim-comment'
    use 'tpope/vim-commentary'
    -- use 'pwntester/octo.nvim'
    -- use 'dyng/ctrlsf.vim'
    use 'vim-scripts/restore_view.vim'
    -- use 'kassio/neoterm'
    -- Why do i have lazygit if i have toggle term??!?!!
    -- use {
	-- 'kdheepak/lazygit.nvim',
	-- cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" }
    -- }
    -- use "akinsho/toggleterm.nvim"
    use {
	'dstein64/vim-startuptime',
	cmd = "StartupTime"
    }
    -- use 'norcalli/profiler.nvim'
    -- use 'github/copilot.vim'

    -- Dashboard
    use {
	'andweeb/presence.nvim',
	cmd = "discord"
    }
    use 'glepnir/dashboard-nvim'

    if packer_bootstrap then
	require('packer').sync()
    end
end)
