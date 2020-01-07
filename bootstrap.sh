#!/bin/sh
apt-get update
apt-get install vim puppet git ruby-bundler
git clone https://github.com/b4ldr/vps-config /etc/puppet/code/production
chwon -R puppet /etc/puppet/code/production
cd /etc/puppet/code/production || exit 1
sudo -u puppet bundle install --path="${BUNDLE_PATH:-.bundle/vendor}"
bundle exec r10k puppetfile install
puppet apply /etc/puppet/code/modules:/usr/share/puppet/modules:/etc/puppet/code/production/modules /etc/puppet/code/production/manifests/ssh.pp
