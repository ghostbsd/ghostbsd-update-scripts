#!/usr/bin/env sh

openrc_services=`rc-update | grep -v boot | grep -v nonetwork | grep -v shutdown | grep -v ntpd | grep -v dbus | grep -v webcamd | grep -v cupsd | grep -v lightdm | grep -v 'avahi-daemon' | grep -v 'avahi-dnsconfd' | cut -d '|' -f 1`
echo $openrc_services

# set default services
sysrc zfs_enable="YES"
sysrc kld_list+="linux linux64 cuse fusefs"
sysrc linux_enable="YES"
sysrc ntpd_enable="YES"
sysrc ntpd_sync_on_start="YES"
sysrc devfs_enable="YES"
sysrc devfs_system_ruleset="devfsrules_common"
sysrc dbus_enable="YES"
sysrc lightdm_enable="YES"
sysrc webcamd_enable="YES"
sysrc cupsd_enable="YES"
sysrc avahi_daemon_enable="YES"
sysrc avahi_dnsconfd_enable="YES"

for service in $openrc_services ; do
  sysrc `echo $service | tr - _`_enable="YES"
done

sysrc -f /boot/loader.conf rc_system="bsdrc"
