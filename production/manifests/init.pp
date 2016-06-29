# Class: sysctl
#
# This module manages sysctl
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class sysctl {

  file { '/etc/sysctl.conf':
    ensure => file
  }

  exec { 'sysctl/reload':
    path        => ['/sbin'],
    command     => 'sysctl -p /etc/sysctl.conf',
    refreshonly => true,
    subscribe   => File['/etc/sysctl.conf']
  }

}
