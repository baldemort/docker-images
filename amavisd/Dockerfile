FROM ubuntu:20.04

RUN echo Start to build ... \
 && groupadd -g 10001 vmail \
 && useradd -u 10001 -g 10001 vmail \
 && groupadd -g 802 amavis \
 && useradd -u 802 -g 802 -d /var/lib/amavis -s /bin/sh amavis \
 && mkdir -p /var/lib/amavis \
 && chown amavis:amavis /var/lib/amavis \
 && groupadd -g 803 clamav \
 && useradd -u 803 -g 803 -G 802 -d /var/lib/clamav -s /bin/false clamav \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    amavisd-new clamav-daemon spamassassin \
 && rm -rf /var/lib/apt/lists/*

CMD hostname > /etc/mailname \
 && service clamav-daemon start \
 && service clamav-freshclam start \
 && service amavis start \
 && tail -F /var/log/clamav/clamav.log /var/log/clamav/freshclam.log
