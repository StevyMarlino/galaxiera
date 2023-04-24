FROM nginx

RUN apt-get update && apt-get install -y openssh-server sudo

RUN groupadd galaxiera && useradd -ms /bin/bash -G galaxiera stevy

RUN sudo passwd -d stevy && usermod -aG sudo stevy

RUN sudo apt install wget build-essential libncursesw5-dev libssl-dev -y \
libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y

RUN sudo apt-get install software-properties-common -y && sudo add-apt-repository ppa:deadsnakes/ppa && sudo apt-get install python3
RUN service ssh start

CMD ["/usr/sbin/sshd","-D"]