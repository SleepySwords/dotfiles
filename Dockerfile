FROM archlinux:latest

RUN pacman -Sy --noconfirm neovim git wget fontconfig bat fzf git-delta fish sudo


RUN useradd dev && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/dev
ENV HOME /home/dev

RUN chown -R dev:dev $HOME
RUN mkdir $HOME/.config
RUN chown -R dev:dev $HOME/.config
USER dev
RUN git clone https://github.com/SleepySwords/dotfiles
RUN mv dotfiles/nvim $HOME/.config/nvim
RUN mv dotfiles/fish $HOME/.config/fish
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

WORKDIR /home/dev/work

CMD nvim
