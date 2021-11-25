$TTL 1h ; Set TTL to one hour for all important RRsets

@	SOA	ns.johnbond.org. dns.johnbond.org. (
		2020020601 ; Serial
		1h ; Refresh
		10m ; Retry
		10d; Expire
		1h ; Negative
)
	NS	loki.johnbond.org.
	NS	ns1.he.net.

	MX	10 loki.johnbond.org.
default._domainkey    TXT "v=DKIM1; t=y; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu2rmDcWQdyp2YU5sqcKLvH9gz6n2x7e0Oa7sXGVRsKJMQWes4eTXIgv1FHk+VL5Uz4kCkVmt8gZyW7f6UEfFFJ4MUS224dJLCngRRpDDAkGjkIMvTzmE3VngzE9gIBoxAzhy7FGaBiNi+wQv9u7DLR5jaIsJpCeMCWXyjdg/7pZm+qH8Dmo0+Umqjh/" "GDKUoyOANQkYhrJ5hkSYHIwV6paVDcCIauV7kkxlGQtlR8c0nhyxMCqsG3uvAidL0qgse6zH06Bw8KUCoDR9sPXCPaZyDupiQkCxdglsLcULF25uL1+eTdWxsG4qpguNFB1sOT/ggEl+kF2DB2zkdnE25UQIDAQAB"

_submission._tcp     SRV 0 1 587 loki.johnbond.org.
_imap._tcp     SRV 0 1 143 loki.johnbond.org.
_imaps._tcp     SRV 0 1 993 loki.johnbond.org.
_smtp._tcp     SRV 0 1 25 loki.johnbond.org.
$TTL 6h ; Set TTL for other RRsets to 6 hours
