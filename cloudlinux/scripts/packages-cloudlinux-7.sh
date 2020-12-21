#!/bin/bash

set -euxo pipefail

# installing cloud-init as per https://www.ibm.com/support/knowledgecenter/SSB27U_6.4.0/com.ibm.zvm.v640.hcpo5/instslesmore.htm

cat <<EOF > /etc/yum.repos.d/local.repo
[Local-base]
name=Local repo - Base
baseurl=http://psabr.plesk.ru/share/mirror/cloudlinux/\$releasever/os/\$basearch/
enabled=1
gpgcheck=0
[Local-updates]
name=Local repo - Updates
baseurl=http://psabr.plesk.ru/share/mirror/cloudlinux/\$releasever/updates/\$basearch/
enabled=1
gpgcheck=0
EOF

yum install -y epel-release

PACKAGES="
python2-pip
python-pip
cloud-utils-growpart
qemu-guest-agent
"

yum -y install ${PACKAGES}

curl -L -o cloud-init.tar.gz http://ad-dump.dev.solusvm.com/cloud-init.tar.gz
tar -xzvf cloud-init.tar.gz
cd cloud-init-19.4

pip install --verbose --upgrade pip
pip install --verbose jsonschema
pip install --verbose importlib-metadata
pip install --verbose requests

python setup.py build
python setup.py install --init-system systemd

systemctl enable cloud-init.service
systemctl enable qemu-guest-agent
