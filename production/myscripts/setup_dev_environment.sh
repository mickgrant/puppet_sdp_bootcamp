if [ ! -f /etc/puppetlabs/code/environments/production/environment.conf ]; then
  echo ERR: Puppet Enterprise is not installed
  echo ERR: Please install it before running this script
  exit 1
fi
cd /etc/puppetlabs/code/environments/production
git init
git remote add origin file:///var/repos/puppet-code.git
cp /etc/puppetlabs/puppet/hiera.yaml .
cd /etc/puppetlabs/puppet
ln -sf /etc/puppetlabs/code/environments/production/hiera.yaml .

# add modules 
puppet module install puppet/archive
puppet module install puppetlabs/apache
puppet module install puppetlabs/concat
puppet module install puppetlabs/ntp
puppet module install puppetlabs/stdlib
puppet module install zanloy/resolv_conf
puppet module install petems/swap_file


exit 0
