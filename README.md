# Neovim config:

## Installation
1. Git clone or download this repo.
2. Copy and paste the contents of the nvim folder into your nvim config installation.
3. First run would sync up the plugins but not apply them, exit and rerun after the sync has been done.

## Docker installation and running
1. Run `docker build -t neovim .` in the dotfiles director to build as an image (This only needs to be run one).
2. Run `docker run -d --tty neovim` to start a container.
3. Run `docker exec -it OUTPUT_FROM_LAST_COMMAND /bin/fish` to enter the container with fish as the shell.

alternatively

2. Run `docker run -it --tty neovim /bin/fish` to start and directly enter the container with fish as the shell.

*Note: You may want to use the -v option to link your file system and the containers file system:* `docker run -it --tty -v (pwd):/home/dev/work neovim /bin/fish`

Press Ctrl-D to exit the shell.

## Dependencies and requirements
- Require minimum neovim 0.7 for lsp and treesitter
- The theme requires a terminal with true colours (or you could change the default theme)
    - Mac OS default terminal doesn't support true colours :(
- nvim-lsputils requires [bat](https://github.com/sharkdp/bat) (this is lokecat but able to better colouring / formatting) to be installed.
- fzf.vim requires [fzf](https://github.com/junegunn/fzf) and [delta](https://github.com/dandavison/delta) to be installed.
- [Rust-analyzer](https://rust-analyzer.github.io/) may be installed as it being used as a source for rust lsp.
- DAP servers also should be installed in ~/.local/share/nvim/dap_servers and setup as their own individual dbg file (see python.lua in dbg)
    - python, javascript, rust and c# already have configs but the dap servers don't come preinstalled
	- You'll have to install them manually (should probs use a dap installer plugin)

## Credits
- Nvim config based on https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060
    - It's probably nowhere near the same anymore
