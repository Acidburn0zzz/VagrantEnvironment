## AUTHOR: Amina OUROUBA
## for: CopyPeste's testing environment
##
##	This script aims to setup an OpenBSD environment. It is mandatory to
## use it since the downloaded box has a 10Go virtual hdd by default : that may
## cause disk space issues if you plan to download heavy data (OpenBSD's ports
## tree for instance ;)).
##	It creates the virtual machine and resizes the disk, thus, it has to be
## ran only once. When you're done with this script, the only commands you have
## to use are vagrant up/halt/ssh and consorts. You won't need this file anymore
## unless you destroyed your environment.
##


#!/bin/sh

#set -ex

##
#
# This command creates the virtual machine. This is the first step of the script since when created,
# the vm has a 10Go HD that we need to resize in order to be able to download the ports tree.
#
##
echo "[*\SETUP_ENV/*]____>>____: Creating the machine...\t\t                          (0%)\r"
vagrant up
echo "[*\SETUP_ENV/*]____>>____: Halting the machine...\t\t#####                     (25%)\r"
vagrant halt

##
#
# Cloning, resizing and replacing the VM disk :)
#
##
echo "[*\SETUP_ENV/*]____>>____: Cloning the machine disk...\t\t###########               (40%)\r"
VBoxManage clonehd "$HOME/VirtualBox VMs/CPEnv_OpenBSD/packer-openbsd-5.8-amd64-disk1.vmdk" "$HOME/VirtualBox VMs/CPEnv_OpenBSD/packer-openbsd-5.8-amd64-disk1.vdi" --format vdi

echo "[*\SETUP_ENV/*]____>>____: Resizing the disk...\t\t#############             (50%)\r"
VBoxManage modifyhd "$HOME/VirtualBox VMs/CPEnv_OpenBSD/packer-openbsd-5.8-amd64-disk1.vdi" --resize 130000

echo "[*\SETUP_ENV/*]____>>____: Attaching the new disk to the machine...\t\t###############           (60%)\r"
VBoxManage storageattach CPEnv_OpenBSD --storagectl "IDE Controller" --port 0 --device 0 --type "hdd" --medium "$HOME/VirtualBox VMs/CPEnv_OpenBSD/packer-openbsd-5.8-amd64-disk1.vdi"

##
#
# Now updating the partition thanks to reprovosion for fs extension
#
##
echo "[*\SETUP_ENV/*]____>>____: Extending the FS...\t\t###################       (80%)\r"
vagrant up && vagrant --setup provision
vagrant reload 
echo "[*\SETUP_ENV/*]____>>____: Extending the FS...\t\t#######################   (100%)\r"
echo "\n[*\SETUP_ENV/*]____>>____: You can now connect to the machine just typing: vagrant ssh"
echo "\n[*\SETUP_ENV/*]____>>____: If you want to download the ports tree, run : sudo su; sh /vagrant/get_ports.sh"
