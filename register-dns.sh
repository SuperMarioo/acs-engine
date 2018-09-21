#!/bin/bash
# Add support for registering host on dns server. Must allow non-secure updates

set -e

DOMAINNAME=$1

if ! grep -Fq "${DOMAINNAME}" /etc/dhcp/dhclient.conf
then
    echo $(date) " - Adding domain to dhclient.conf"

    echo "supersede domain-name \"${DOMAINNAME}\";" >> /etc/dhcp/dhclient.conf
    echo "prepend domain-search \"${DOMAINNAME}\";" >> /etc/dhcp/dhclient.conf
fi

# service networking restart
echo $(date) " - Restarting network"
sudo ifdown eth0 && sudo ifup eth0
