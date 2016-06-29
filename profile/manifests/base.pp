class profile::base {

  $sysctl = hiera_array('sysctl')
  $ntp_servers = hiera_array('ntp::servers')
  $nameservers = hiera_array('nameservers')

  ## SYSCTL Config
  file { '/etc/sysctl.conf':
    ensure => file,
    content => template('profile/sysctl.conf.erb'),
  }
  
  ## NTP Config
  class { '::ntp':
    servers => $ntp_servers,
  }
  

  ## DNS Config
  class { '::resolv_conf':
    nameservers => $nameservers,
  }
  
  ## Swap File 2GB
  ## https://gitlab.com/SydOps/puppet-swap_file
  class { 'swap_file':
    ensure => present,
    swapfile      => '/tmp/swapfile',
    swapfilesize  => '2000000000',
  }

}

