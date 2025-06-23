FROM debian

RUN apt update
RUN apt install -y python3 python3-pip python3.11-venv gdb sudo neovim git wget curl zsh

RUN useradd -ms /bin/bash swords
RUN usermod -aG sudo swords
RUN echo "swords\nswords" | passwd swords

USER swords

WORKDIR /home/swords

RUN python3 -m venv test

RUN cd test && ./bin/pip3 install pwntools

# RUN pip3 install pwntools
RUN bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

CMD "/bin/zsh"
