FROM debian:latest

COPY --from=adoptopenjdk:8-jdk-hotspot /opt/java/openjdk /opt/jdk
ENV JAVA_HOME=/opt/jdk

RUN    env DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && env DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && env DEBIAN_FRONTEND=noninteractive apt-get -y install curl dumb-init bzip2 python2 python-tk python-pil libsdl1.2debian libsdl-image1.2 libsdl-ttf2.0-0 libglu1-mesa libqt5widgets5 libqt5qml5 libgtk2.0-0 libqt5widgets5 libqt5qml5 libqt5concurrent5 xterm libopenal1 procps \
    && update-alternatives --install /usr/bin/python python /usr/bin/python2 1

RUN    curl -L -o /dwarfpack.tar.bz2 https://github.com/McArcady/lnp-forge/releases/download/0.47.04-r2/LinuxDwarfPack-0.47.04-r2.tar.bz2 \
    && mkdir -p /dwarfpack/game \
    && tar -C /dwarfpack/game --strip-components=1 -xf /dwarfpack.tar.bz2 \
    && rm /dwarfpack.tar.bz2

# what...
RUN    mv -v /dwarfpack/game/bin/dwarftherapist /dwarfpack/game/bin/DwarfTherapist

# Savegames
RUN    ln -svf /data/save /dwarfpack/game/df_47_04_linux/data/save
RUN    ln -svf /data/PyLNP.user /dwarfpack/game/PyLNP.user

# TODO: add user

COPY ./entrypoint.sh /

VOLUME /data
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
