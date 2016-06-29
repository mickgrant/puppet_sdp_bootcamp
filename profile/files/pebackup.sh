#!/bin/bash
# Puppet Enterprise Backup script 

PATHS="/etc/puppetlabs /etc/puppetlabs/code/environments/production/modules /etc/puppetlabs/code/modules /etc/puppetlabs/code/modules /opt/puppetlabs/puppet/modules /opt/puppetlabs/server/data/console-services/certs /opt/puppetlabs/server/data/postgresql/9.4/data/certs /etc/puppetlabs/puppetserver/conf.d/"

DATE=`date +"%m-%d-%y"`

## Backup Puppet Enterprise 
cd /tmp && tar -zcvf pebackup_${DATE}.tar.gz $PATHS

## Backup PuppetDB
sudo -u pe-postgres /opt/puppetlabs/server/apps/postgresql/bin/pg_dumpall -c -f puppetdb_backup_${DATE}.sql
