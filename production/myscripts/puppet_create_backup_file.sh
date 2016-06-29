#!/bin/bash
# Puppet Enterprise Backup script 

PATHS="/etc/puppetlabs/ /etc/puppetlabs/code/environments/production/modules /etc/puppetlabs/code/modules /etc/puppetlabs/code/modules /opt/puppetlabs/puppet/modules /opt/puppetlabs/server/data/console-services/certs /opt/puppetlabs/server/data/postgresql/9.4/data/certs /etc/puppetlabs/puppetserver/conf.d/"


cd /tmp && tar -zcvf pebackup.tar.gz $PATHS

