# Neovim config:

## Installation
1. Git clone or download this repo.
2. Copy and paste the contents of the nvim folder into your nvim config installation.
3. First run would produce a bunch of errors as no plugins are installed, use the :PackerSync command and run again.

## Dependencies and requirements
- Require minimum neovim 0.5.1 for lsp
- The theme requires a terminal with true colours (or you could change the default theme)
    - Mac OS default terminal doesn't support true colours :(
- nvim-lsputils requires [bat](https://github.com/sharkdp/bat) (this is lokecat but able to better colouring / formatting) to be installed.
- fzf.vim requires [fzf](https://github.com/junegunn/fzf) and [delta](https://github.com/dandavison/delta) to be installed.
- [Rust-analyzer](https://rust-analyzer.github.io/) must be installed as it being used as a source.

## Credits
- Nvim config based on https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060
    - It's probably nowhere near the same anymore
