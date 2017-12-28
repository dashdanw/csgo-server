FROM centos:7

ENV USER csgoserver

RUN yum install -y sudo iproute file mailx postfix curl wget bzip2 gzip unzip python binutils bc tmux glibc.i686 libstdc++ libstdc++.i686

RUN useradd -m $USER && usermod -aG wheel $USER

USER $USER

WORKDIR /home/$USER

RUN wget -N --no-check-certificate https://gameservermanagers.com/dl/linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csgoserver

RUN ./csgoserver auto-install

USER root

ADD ./config/csgoserver.cfg ./serverfiles/csgo/cfg/csgoserver.cfg

RUN chown $USER:$USER /home/$USER/serverfiles/csgo/cfg/csgoserver.cfg

USER $USER

EXPOSE 27015:27015

EXPOSE 27015:27015/udp
