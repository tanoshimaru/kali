FROM kalilinux/kali-rolling

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget kali-linux-headless

RUN wget https://gitlab.com/kalilinux/recipes/kali-scripts/-/raw/main/xfce4.sh && \
    chmod +x xfce4.sh && \
    ./xfce4.sh

RUN apt-get install -y dbus-x11

RUN echo "root:root" | chpasswd

ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID kali && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo kali && \
    echo "kali:kali" | chpasswd && \
    echo "kali    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER kali
WORKDIR /home/kali

CMD sudo /etc/init.d/xrdp start && tail -f /dev/null
