#!/bin/sh

set -ex

disklabel -E wd0 < /vagrant/provisioning/data/diskspace_infos
#mkdir /ports_tree

newfs wd0l
mount -o async,noatime /dev/wd0l /mnt

cd /mnt
dump -0af - /usr | restore -rf -
rm restoresymtable
perl -i -pe 's/\.f/\.l/' /etc/fstab
#mount -a

