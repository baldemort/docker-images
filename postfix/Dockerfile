FROM ubuntu:20.04

COPY entrypoint.sh /entrypoint.sh

RUN echo Start to build ... \
 && groupadd -g 10001 vmail \
 && useradd -u 10001 -g 10001 vmail \
 && mkdir /home/vmail \
 && chown vmail:vmail /home/vmail \
 && groupadd -g 802 postfix \
 && useradd -u 802 -g 802 -d /var/spool/postfix -s /bin/false postfix \
 && groupadd -g 803 courier \
 && useradd -u 803 -g 803 -d /var/lib/courier -s /bin/false courier \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    moreutils postfix-ldap courier-authdaemon courier-authlib-ldap libcourier-unicode4 \
 `# maildrop problem: https://bugs.launchpad.net/ubuntu/+source/maildrop/+bug/1813467` \
 `# Workaround: https://askubuntu.com/questions/482928/ignore-apt-get-postinstall-scripts-automatically` \
 && cd /tmp \
 && apt-get download maildrop \
 && dpkg --unpack /tmp/maildrop*.deb \
 && rm -f /var/lib/dpkg/info/maildrop.postinst \
 && dpkg --configure maildrop \
 && apt-get install -yf \
 && rm -f /tmp/maildrop*.deb \
 && sed -i 's/^authmodulelist=.*/authmodulelist="authldap"/' /etc/courier/authdaemonrc \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /entrypoint.sh

CMD /entrypoint.sh
