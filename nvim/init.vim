"---- vim-plug setup  ----
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif
"-------- end vim-plug setup ----

set nocompatible

call plug#begin('~/.config/nvim/plugged')

" Sensible default 
Plug 'tpope/vim-sensible'

" Color schemes
Plug 'sainnhe/edge'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'matsuuu/pinkmare'
Plug 'lifepillar/vim-solarized8'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'kabouzeid/nvim-lspinstall'

" Omnisharp completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim'

" Code snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Status line
Plug 'glepnir/galaxyline.nvim'
Plug 'akinsho/nvim-bufferline.lua'

" Debugging
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
autocmd vimenter * ++nested colorscheme edge

let mapleader='z'
let maplocalleader='\'

syntax enable
filetype plugin indent on

set nu rnu
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set tabstop=4 shiftwidth=4 expandtab
set autoindent smartindent
set cmdheight=2
set updatetime=50
set signcolumn=yes
set clipboard=unnamed,unnamedplus
set showmatch

set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

nnoremap <Space>v :e ~/.config/nvim/init.exp2.vim<CR>

" ----------------- Omnisharp ------------------------------
let g:OmniSharp_server_use_mono = 1
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_force_refresh_on_context_changed = 1

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2


" -------------------- LSP ---------------------------------
luafile ~/.config/nvim/lsp.lua

nnoremap <leader>vd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi <cmd>lua vim.lsp.buf.implementation()<CR>

:lua << EOF
  require("bufferline").setup{
    -- Using vim in a terminal, so no need for this.
    show_close_icon = false,
    diagnostics = "nvim_lsp"
  }
EOF

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <silent> <C-p> <Plug>(completion_trigger)

" -------------------- LSP ---------------------------------

" Code snippets
let g:completion_enable_snippet = 'UltiSnips'

" Fuzzy finder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>

" Buffer handling
nmap L :let &number=1-&number<CR>
nmap <leader>l :bnext<CR>
nmap <c-h> :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
nmap <leader>0 :set invnumber<CR>
" map :q to byffer delete
" http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit
cnoreabbrev <expr> q getcmdtype() == ":" && (getcmdline() == 'q' && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1) ? 'bd' : 'q'

" Syntax
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
EOF

" File explorer
nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tn :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

" Status line
luafile ~/.config/nvim/eviline.lua

" Debugging
lua <<EOF
require('telescope').load_extension('dap')
require('dap-python').setup('~/miniconda3/bin/python')
EOF
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dd :lua require('dap').continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>`
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>v

" Keybind for https://vi.stackexchange.com/questions/24502/deleting-without-copying-to-clipboard-in-windows
" https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
nnoremap \ "_

vmap <Tab> >gv
vmap <S-Tab> <gv
