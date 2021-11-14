NVIM:
- Requires neovim 0.5.1
- Nvim config based on https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060
    - It's probably nowhere near the same anymore
- Need a terminal with true colours (or change the theme) Mac OS default terminal doesn't support true colours :(
- Other dependencies need to be installed
    - nvim-lsputils requires [bat](https://github.com/sharkdp/bat) (like cat but able to better colouring / formatting)
    - fzf.vim requires [fzf](https://github.com/junegunn/fzf) + [delta](https://github.com/dandavison/delta)
- First run would produce a bunch of errors as no plugins are installed, use the :PackerSync command
