#!/bin/bash

set -euxo pipefail

PACKAGES="
cagefs
alt-php73
alt-php74
mod_lsapi
"

yum -y install ${PACKAGES}

# for init of cagefs /usr/bin/php must exist
# from logs:
# ...
# Updating statuses of users ...
# Error: failed to run /usr/bin/php -c /etc/php.ini -qm

ln -s /opt/plesk/php/7.3/bin/php /usr/bin/php