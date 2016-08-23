#echo "WRKOBJDIR=/ports_tree/build/ports
#DISTDIR=/ports_tree/build/distfiles
#PACKAGE_REPOSITORY=/ports_tree/packages" >> /etc/mk.conf

cd /tmp
ftp http://ftp.openbsd.org/pub/OpenBSD/$(uname -r)/ports.tar.gz
ftp http://ftp.openbsd.org/pub/OpenBSD/$(uname -r)/SHA256.sig
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz


cd /usr
tar xzf /tmp/ports.tar.gz
mkdir /usr/X11R6/man && touch /usr/X11R6/man/mandoc.db
cd ports
#make dump-vars
/usr/ports/infrastructure/bin/dpb -DCOLOR -F 4
