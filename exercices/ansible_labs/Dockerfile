FROM nginx

RUN apt-get update && apt-get install -y openssh-server sudo

#Creation d'un utilisateur et d'un groupe
RUN groupadd galaxiera && useradd -ms /bin/bash -G galaxiera stevy

# copy de la clé publique dans l'image
COPY container_shared.pub  /home/stevy/.ssh/authorized_keys 

# creation du directorie de l'utilasteur stevy
RUN mkdir -p /home/stevy/.ssh && chown -R stevy:galaxiera /home/stevy/.ssh/

RUN chmod 600 /home/stevy/.ssh/authorized_keys

# retirer le mot de passe utilisateur lorsqu'il veut se donner des privilèges
RUN sudo passwd -d stevy

# ajouter l'utilisateur dans le groupe sudo
RUN usermod -aG sudo stevy

RUN sudo apt install wget build-essential libncursesw5-dev libssl-dev -y \
libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y

RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt-get install python3
RUN service ssh start

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]