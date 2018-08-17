FROM centos:7

ENV USER csgoserver

RUN yum install -y epel-release

RUN yum install -y sudo iproute file mailx postfix curl wget bzip2 gzip unzip python binutils bc jq tmux glibc.i686 libstdc++ libstdc++.i686 ncurses-libs.i686

RUN useradd -m $USER && usermod -aG wheel $USER

USER $USER

WORKDIR /home/$USER

RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csgoserver

RUN ./csgoserver auto-install

USER root

ADD ./config/* ./serverfiles/csgo/cfg/

RUN chown -R $USER:$USER /home/$USER/serverfiles/csgo/cfg/

USER $USER

EXPOSE 27015:27015

EXPOSE 27015:27015/udp
