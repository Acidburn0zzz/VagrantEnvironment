#!/bin/sh

#dir="$(dirname "$0")"

# this line to fix that FCKING DUMMY default configuration setting the DNS to localhost domain... Setting the NS to Google primary DNS 
sudo -s <<EOF
echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

# installing bash because ksh is a kind of creeper...
export PKG_PATH="http://ftp.openbsd.org/pub/OpenBSD/5.7/packages/amd64/"
pkg_add -i -v bash
ln -sf /usr/local/bin/bash /bin/bash
# thx to these two lines we set the default shell for vagrant user and root user. SO USEFUL!
chsh -s /bin/bash vagrant
#chsh -s /bin/bash root

# executing next configuration script (with bash ;))))
sudo /vagrant/config.sh
