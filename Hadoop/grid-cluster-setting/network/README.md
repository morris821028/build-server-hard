## README.md ##

### Package ###

```bash
apt-get install isc-dhcp-server
apt-get install bind9
```

### Step ###

* `dhcpd.conf`: `/etc/dhcp/dhcpd.conf` DHCP Server
* `hosts`: `/etc/hosts` cluster host name setting
* `interfaces`: `/etc/network/interfaces` DHCP sever network interface setting
* `sshd_config`: `/etc/ssh/sshd_config` Debian Install
* edit `/etc/sysctl.conf` to open `net.ipv4.ip_forward=1`
* `start-ipable.sh`: cluster node NAT setting
