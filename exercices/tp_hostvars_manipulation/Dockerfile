FROM smarlino/ubuntu-cible:1.0

ARG SSH_KEY_FILE
ARG USER
ENV USER ${USER:-marlino}
ENV SSH_KEY_FILE ${SSH_KEY_FILE:-marlino}

RUN apt install sudo
RUN useradd $USER -ms /bin/bash && usermod -aG sudo $USER 
COPY $SSH_KEY_FILE.pub /home/$USER/.ssh/authorized_keys
RUN passwd -d $USER