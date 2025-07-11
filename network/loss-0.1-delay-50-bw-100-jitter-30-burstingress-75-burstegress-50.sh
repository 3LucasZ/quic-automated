/sbin/tc qdisc del dev en0 root
/sbin/tc qdisc del dev en0 ingress
/sbin/tc qdisc del dev en0 ingress
/sbin/tc qdisc del dev ifb0 root
/usr/bin/ip link set dev ifb0 down
/usr/bin/ip link delete ifb0 type ifb

/sbin/tc qdisc add dev en0 root handle 1a64: htb default 1
/sbin/tc class add dev en0 parent 1a64: classid 1a64:1 htb rate 10000000.0kbit
/sbin/tc class add dev en0 parent 1a64: classid 1a64:104 htb rate 100000.0Kbit ceil 100000.0Kbit burst 125000.0KB cburst 125000.0KB
/sbin/tc qdisc add dev en0 parent 1a64:104 handle 2054: netem loss 0.100000% 50% delay 25.0ms 30.0ms
/sbin/tc filter add dev ens192 protocol ip parent 1a64: prio 5 u32 match ip dst 0.0.0.0/0 match ip src 0.0.0.0/0 flowid 1a64:104

modprobe ifb
/usr/bin/ip link add ifb0 type ifb
/usr/bin/ip link set dev ifb0 up
/sbin/tc qdisc add dev en0 ingress
/sbin/tc filter add dev ens192 parent ffff: protocol ip u32 match u32 0 0 flowid 1a64: action mirred egress redirect dev ifb0

/sbin/tc qdisc add dev ifb0 root handle 1a64: htb default 1
/sbin/tc class add dev ifb0 parent 1a64: classid 1a64:1 htb rate 10000000.0kbit
/sbin/tc class add dev ifb0 parent 1a64: classid 1a64:104 htb rate 100000.0Kbit ceil 100000.0Kbit burst 125000.0KB cburst 125000.0KB
/sbin/tc qdisc add dev ifb0 parent 1a64:104 handle 2054: netem loss 0.100000% 75%
/sbin/tc filter add dev ifb0 protocol ip parent 1a64: prio 5 u32 match ip dst 0.0.0.0/0 match ip src 0.0.0.0/0 flowid 1a64:104

