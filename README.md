# Neovim config:

## Installation
1. Git clone or download this repo.
2. Copy and paste the contents of the nvim folder into your nvim config installation.
3. The first run should sync up the plugins but does not apply them, exit and rerun after the sync has been done.

## Docker installation and running
1. Run `docker build -t neovim .` in the dotfiles director to build as an image (This only needs to be run one).
2. Run `docker run -d --tty neovim` to start a container.
3. Run `docker exec -it OUTPUT_FROM_LAST_COMMAND /bin/fish` to enter the container with fish as the shell.

alternatively

2. Run `docker run -it --tty neovim /bin/fish` to start and directly enter the container with fish as the shell.

*Note: You may want to use the -v option to link your file system and the containers file system:* `docker run -it --tty -v (pwd):/home/dev/work neovim /bin/fish`

Press Ctrl-D to exit the shell.

## Dependencies and requirements
- Minimum requirement neovim 0.7+ because of lsp and treesitter
- The default theme requires a terminal with true colours (or you could change the default theme)
    - Mac OS default terminal doesn't support true colours :(
    - Use kitty :)
- nvim-lsputils requires [bat](https://github.com/sharkdp/bat) (which is like cat but with to better colouring / formatting) to be installed.
- fzf.vim requires [fzf](https://github.com/junegunn/fzf) and [delta](https://github.com/dandavison/delta) to be installed.
- [Rust-analyzer](https://rust-analyzer.github.io/) for rust lsp.
- If you are using the skhd config, make sure to install [borders](https://github.com/FelixKratz/JankyBorders)

## Credits
- Nvim config based on https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060
    - It's probably nowhere near the same anymore
