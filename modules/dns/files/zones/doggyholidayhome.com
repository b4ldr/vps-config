$TTL 1h ; Set TTL to one hour for all important RRsets

@	SOA	ns.johnbond.org. dns.johnbond.org. (
		2020010400 ; Serial
		1h ; Refresh
		10m ; Retry
		10d; Expire
		1h ; Negative
)
	NS	loki.johnbond.org.
	NS	ns1.he.net.

@       A       199.38.182.204
@       AAAA    2607:f740:e::f2d
www       A       199.38.182.204
www       AAAA    2607:f740:e::f2d
       
