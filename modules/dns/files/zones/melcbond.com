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

	MX	10 ns.johnbond.org.
$TTL 6h ; Set TTL for other RRsets to 6 hours
default._domainkey    TXT "v=DKIM1; t=y; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu2rmDcWQdyp2YU5sqcKLvH9gz6n2x7e0Oa7sXGVRsKJMQWes4eTXIgv1FHk+VL5Uz4kCkVmt8gZyW7f6UEfFFJ4MUS224dJLCngRRpDDAkGjkIMvTzmE3VngzE9gIBoxAzhy7FGaBiNi+wQv9u7DLR5jaIsJpCeMCWXyjdg/7pZm+qH8Dmo0+Umqjh/" "GDKUoyOANQkYhrJ5hkSYHIwV6paVDcCIauV7kkxlGQtlR8c0nhyxMCqsG3uvAidL0qgse6zH06Bw8KUCoDR9sPXCPaZyDupiQkCxdglsLcULF25uL1+eTdWxsG4qpguNFB1sOT/ggEl+kF2DB2zkdnE25UQIDAQAB"

