FROM ubuntu:20.04

# maildrop problem: https://bugs.launchpad.net/ubuntu/+source/maildrop/+bug/1813467
# Workaround: https://askubuntu.com/questions/482928/ignore-apt-get-postinstall-scripts-automatically
RUN groupadd -g 801 syslog \
 && useradd -u 801 -g 801 -G adm -d /home/syslog -s /bin/false syslog \
 && groupadd -g 802 amavis \
 && useradd -u 802 -g 802 -d /var/lib/amavis -s /bin/sh amavis \
 && mkdir -p /var/lib/amavis \
 && chown amavis:amavis /var/lib/amavis \
 && groupadd -g 803 clamav \
 && useradd -u 803 -g 803 -G 802 -d /var/lib/clamav -s /bin/false clamav \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    amavisd-new rsyslog clamav-daemon spamassassin \
 && sed -i '/imklog/d' /etc/rsyslog.conf \
 && rm -rf /var/lib/apt/lists/*

CMD hostname > /etc/mailname \
 && service rsyslog start \
 && service clamav-daemon start \
 && service clamav-freshclam start \
 && service amavis start \
 && tail -F /var/log/mail.log
