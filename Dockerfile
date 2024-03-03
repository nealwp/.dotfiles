FROM ubuntu:latest

ENV TERM=screen-256color
ENV NVM_DIR=/home/nealwp/.nvm

RUN apt-get update
RUN apt-get install -y tmux git wget sudo build-essential software-properties-common python-is-python3


RUN useradd -ms /bin/bash nealwp && echo "nealwp:god" | chpasswd && adduser nealwp sudo

USER nealwp

WORKDIR /home/nealwp

COPY .bashrc .tmux.conf .vimrc .
COPY ./bin/ ./bin/

# setup nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . ./.nvm/nvm.sh \
    && nvm install --lts \
    && nvm use default

# setup nvim
RUN mkdir -p .config/nvim
RUN git -C .config clone https://github.com/nealwp/nvim-config.git nvim
RUN bash -c "echo 'god' | sudo -S ./.config/nvim/update"
RUN bash -c "echo 'god' | sudo -S ln -s /squashfs-root/usr/bin/nvim /usr/bin/nvim"
RUN bash -c "./.config/nvim/setup"
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

RUN bash -c "echo 'god' | sudo -S chown nealwp:nealwp .*"
RUN bash -c "echo 'god' | sudo -S chown -R nealwp:nealwp bin"
RUN bash -c "echo 'god' | sudo -S chown nealwp:nealwp .*"


