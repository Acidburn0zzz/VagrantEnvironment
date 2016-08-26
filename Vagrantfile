# -*- mode: ruby -*-
# vi: set ft=ruby :

##
# Useful feature still missing to vagrant : passing args from cmd line. Until I found
# this trick, I used to create/read env variables (not the best way but still, the most common one).
# Credits: from http://www.shakedos.com/2014/Feb/25/passing-vagrant-command-line-parameters.html
##
require 'getoptlong'
opts = GetoptLong.new(
  [ '--setup', GetoptLong::OPTIONAL_ARGUMENT ]
)
setup = false
opts.each do |opt, arg|
  case opt
  when '--setup'
    setup = true
  end
end


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "kaorimatz/openbsd-5.8-amd64"
  
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.network "private_network", ip: "10.0.0.3"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider :virtualbox do |vb|
    #vb.gui = true
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.cpus = 2
    vb.memory = 4096
    vb.name = "CPEnv_OpenBSD"
  end
  

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  if setup == true
    config.vm.provision "shell",
                        inline: "/bin/sh /vagrant/provisioning/extend_partition.sh
                                /bin/sh /vagrant/provisioning/requirements.sh;
                                /bin/sh /vagrant/provisioning/provision.sh"
  end
end
