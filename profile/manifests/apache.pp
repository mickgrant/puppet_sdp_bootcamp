class profile::apache {

## Apache Config
  
  include '::archive' 
  
  file { '/opt/staging':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755', 
  }
      
  archive { 'tar':
    path          => '/tmp/apache-tomcat-8.0.35-deployer.tar.gz',
    source        => 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.35/bin/apache-tomcat-8.0.35-deployer.tar.gz',
    checksum      => 'a9a9f6f8ccfc503e92e8b7bd0d0b197c',
    checksum_type => 'md5',
    extract       => true,
    extract_path  => '/opt/staging',
    cleanup       => true,
  }
  

  class { 'apache':
    mpm_module        => 'prefork',
    server_signature  => 'off',
  }
  
  include apache::mod::php
  include apache::mod::alias
  include apache::mod::perl
  include apache::mod::rewrite
  include apache::mod::status




}
