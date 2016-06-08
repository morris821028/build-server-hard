#!/bin/bash
iptables -t nat -A POSTROUTING --out-interface eth0 -j MASQUERADE
iptables -A FORWARD --in-interface eth1 -j ACCEPT

#iptables -t nat -A PREROUTING -p tcp -d 140.112.31.163 --dport 50070 -j DNAT --to 192.168.1.12:50070
#iptables -t nat -A PREROUTING -p tcp -d 140.112.31.163 --dport 8083 -j DNAT --to 192.168.1.13:8083
