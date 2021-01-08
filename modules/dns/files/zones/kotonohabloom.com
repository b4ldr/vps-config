$TTL 1h ; Set TTL to one hour for all important RRsets

@	SOA	ns.johnbond.org. dns.johnbond.org. (
		2021010600 ; Serial
		1h ; Refresh
		10m ; Retry
		10d; Expire
		1h ; Negative
)
	NS	loki.johnbond.org.
	NS	ns1.he.net.

	MX	10 loki.johnbond.org.
    A 67.205.10.42
$TTL 6h ; Set TTL for other RRsets to 6 hours
www A 67.205.10.42
