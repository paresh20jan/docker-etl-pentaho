FROM    ubuntu:16.04

MAINTAINER Yannick Mols

RUN     apt-get update && \
        DEBIAN_FRONTEND=noninteractive \
        apt-get -y install --no-install-recommends openjdk-8-jre-headless && \
        apt-get -y install --no-install-recommends unzip && \
        apt-get -y install --no-install-recommends git && \
        apt-get -y install --no-install-recommends ssh && \
        apt-get -y install --no-install-recommends libwebkitgtk-1.0-0 && \
	apt-get -y install xvfb gtk2-engines-pixbuf && \
	apt-get -y install --no-install-recommends apt-utils && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists && \
        apt-get purge -y --auto-remove

RUN apt-get update
RUN apt-get  install -y xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps

ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb
ADD xvfb_daemon_run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run

ENV DISPLAY :99

WORKDIR /opt/
COPY data-integration ./data-integration

ENTRYPOINT ["/bin/bash"]

