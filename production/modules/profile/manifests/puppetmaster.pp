## PERFECTO25 PuppetMaster setup

class profile::puppetmaster {


#SSH key for r10k/Code Manager to connect to GitHub
$r10k_ssh_key_file = '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa'

  file { '/etc/puppetlabs/puppetserver/ssh':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec { 'create r10k ssh key' :
    command => "/usr/bin/ssh-keygen -t rsa -b 4096 -C 'r10k' -f ${r10k_ssh_key_file} -q -N ''",
    creates => $r10k_ssh_key_file,
    require => File['/etc/puppetlabs/puppetserver/ssh'],
  }

  file { $r10k_ssh_key_file:
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'root',
    mode    => '0600',
    require => Exec['create r10k ssh key'],
  }

  file { "${r10k_ssh_key_file}.pub":
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'root',
    mode    => '0644',
    require => Exec['create r10k ssh key'],
  }
 

  ## HIERA config
# class { '::hiera':
#    hierarchy          => [ 'node/%{::hostname}','%{::operatingsystem}','common'],
#    hiera_yaml         => '/etc/puppetlabs/puppet/hiera.yaml',
#    datadir            => '/etc/puppetlabs/code/environments/%{::environment}/hieradata',
#    puppet_conf_manage => true,
#    create_symlink     => true,
#    eyaml              => false,
#    eyaml_extension    => 'yaml',
#    owner              => 'pe-puppet',
#    group              => 'pe-puppet',
#    notify             => Service['pe-puppetserver'],
#  }

# Backup Puppet Enterprise files

file { 'pebackup.sh':
  ensure => file,
  path   => '/tmp/pebackup.sh',
  mode   => '0755',
  source => "puppet:///modules/profile/pebackup.sh",
}


schedule { 'pebackup':
  range  => '20 - 21',
  period => daily,
  repeat => 1,
}

exec { 'run PE backup script':
  path     => [ '/usr/bin', '/usr/sbin' ],
  command  => '/tmp/pebackup.sh',
  schedule => 'pebackup',  
}



}
