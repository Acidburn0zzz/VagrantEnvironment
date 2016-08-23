#!/bin/bash

pkg_add -Uu
pkg_add rsync-3.1.1.tgz 
pkg_add git
pkg_add mongodb
pkg_add emacs-24.5p1-no_x11

pkg_add ruby-2.2.2p0
# all these links to avoid specifying a version after the bin name
ln -sf /usr/local/bin/ruby22 /usr/local/bin/ruby
ln -sf /usr/local/bin/erb22 /usr/local/bin/erb
ln -sf /usr/local/bin/irb22 /usr/local/bin/irb
ln -sf /usr/local/bin/rdoc22 /usr/local/bin/rdoc
ln -sf /usr/local/bin/ri22 /usr/local/bin/ri
ln -sf /usr/local/bin/rake22 /usr/local/bin/rake
ln -sf /usr/local/bin/gem22 /usr/local/bin/gem

gem update --system
gem install bundler
bundle init

# remove these files after provisioning completes!!!!
cat <<EOF > Gemfile
source 'https://rubygems.org'
gem "rspec"
EOF

bundle install
bundle exec rspec
rm Gemfile*

# obviously, ls coloring output
#pkg_add colorls

# for vagrant reguser
#sudo -u vagrant cat <<EOF > /home/vagrant/.bashrc
#!/bin/bash
#alias ls="colorls -G"
#EOF


# debug bashrc wrong owner + color + add alias ..
#source /home/vagrant/.bashrc
#sudo -u vagrant echo "/vagrant/uadd_auto.sh" >> /home/vagrant/.profile

# for root user
# cat <<EOF > ~/.bashrc
# #!/bin/sh
# alias ls="colorls -G"
# EOF

# source ~/.bashrc
