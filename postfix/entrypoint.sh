#!/usr/bin/env bash

set -euo pipefail

# Prepare for running environment
mkdir -p \
    /run/courier/authdaemon \
    /var/spool/postfix/public \
    /var/spool/postfix/maildrop
chgrp postdrop /var/spool/postfix/public /var/spool/postfix/maildrop

# Launch courier daemon and postfix
/usr/lib/courier/courier-authlib/authdaemond 2>&1 \
| /usr/bin/ts '%b %d %H:%M:%S mail courier/authdaemon' &
postfix start-fg 2>&1 &

# Exit container in case either one stops
wait -n
