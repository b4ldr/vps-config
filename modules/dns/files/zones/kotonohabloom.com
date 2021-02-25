$TTL 1h ; Set TTL to one hour for all important RRsets

@	SOA	ns.johnbond.org. dns.johnbond.org. (
		2021022500 ; Serial
		1h ; Refresh
		10m ; Retry
		10d; Expire
		1h ; Negative
)
	NS	loki.johnbond.org.
	NS	ns1.he.net.

	MX	10 loki.johnbond.org.
    A 67.205.10.42
    TXT "v=spf1 ip4:206.189.25.239 ip6:2a03:b0c0:1:e0::4f7:f001 include:_spf.google.com"

$TTL 6h ; Set TTL for other RRsets to 6 hours
www A 67.205.10.42
