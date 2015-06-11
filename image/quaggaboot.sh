#!/bin/sh

/etc/init.d/quagga start

zebra -dP0

for f in rip ripng ospf ospf6; do
    grep -q "router $f\$" $1 && ${f}d -dP0 
done

grep -q "router bgp .*\$" $1 && bgpd -dP0

vtysh << __END__
conf term
`cat $1`
__END__

