FROM amd64/debian:stretch-slim
#FROM amd64/debian:stretch
LABEL maintainer="kolorafa <rafal.kolodziejczyk@itdesk.eu>"

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    fail2ban \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
COPY mikrotik-ban.sh /bin
COPY mikrotik-unban.sh /bin
RUN chmod +x /start.sh /bin/mikrotik-*.sh

#COPY id_rsa /root/.ssh/id_rsa

WORKDIR /etc/fail2ban

ENV MIKROTIK_USER ssh

COPY jail.local ./
COPY filter.d/ ./filter.d/
COPY action.d/ ./action.d/

CMD /start.sh
