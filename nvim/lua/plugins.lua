-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = 'https://github.com/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end


-- Figure how to autoinstall plugins


-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged

return require('packer').startup(function()
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
    -- use 'sickill/vim-monokai'

    --  LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'glepnir/lspsaga.nvim'
    use 'nvim-lua/lsp-status.nvim'

    -- Completion plugins
    -- use 'ms-jpq/coq_nvim'
    -- use 'ms-jpq/coq.artifacts'
    -- use 'ms-jpq/coq.thirdparty'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    use 'simrat39/rust-tools.nvim'

    --  Omnisharp completion
    use 'dense-analysis/ale'
    use {
        'OmniSharp/omnisharp-vim',
        -- requires = {{'prabirshrestha/asyncomplete.vim'}, {'prabirshrestha/async.vim'}}
    }

    --  Code snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'rafamadriz/friendly-snippets'

    --  Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'liuchengxu/vim-clap'

    --  Syntax
    use 'nvim-treesitter/nvim-treesitter' -- , {'do': ':TSUpdate'}
    use 'nvim-treesitter/playground'

    --  File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}  --  for file icons
    }

    --  Status line
    use 'glepnir/galaxyline.nvim'
    use 'akinsho/nvim-bufferline.lua'

    -- Buffers
    use {'ojroques/nvim-bufdel'}

    --  Debugging
    use {'mfussenegger/nvim-dap'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'mfussenegger/nvim-dap-python'}
    use {'rcarriga/nvim-dap-ui'}
    use {'theHamsta/nvim-dap-virtual-text'}
    use {
            "rcarriga/vim-ultest",
            config = "require('config.ultest').post()",
            run = ":UpdateRemotePlugins",
            requires = {"vim-test/vim-test"}
    }
    use {'Pocco81/DAPInstall.nvim'}

    -- Quality of life stuff
    use 'jiangmiao/auto-pairs'
    use 'tomtom/tcomment_vim'
    use 'pwntester/octo.nvim'
    use 'dyng/ctrlsf.vim'
    use 'vim-scripts/restore_view.vim'
    use 'kassio/neoterm'
    use 'kdheepak/lazygit.nvim'

    -- Dashboard
    use 'andweeb/presence.nvim'
    use 'glepnir/dashboard-nvim'
end)
