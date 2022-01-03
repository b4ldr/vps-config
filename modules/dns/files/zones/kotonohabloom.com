$TTL 1h ; Set TTL to one hour for all important RRsets

@	SOA	ns.johnbond.org. dns.johnbond.org. (
		2022030100 ; Serial
		1h ; Refresh
		10m ; Retry
		10d; Expire
		1h ; Negative
)
	NS	loki.johnbond.org.
	NS	ns1.he.net.

	MX	10 loki.johnbond.org.
    A 67.205.10.42
    TXT "google-site-verification=d5GPcuQSylxdc9W56zy-oFRwLKSe1fDfGRjwb8N__lo"
    TXT "v=spf1 +mx ip4:206.189.25.239 ip6:2a03:b0c0:1:e0::4f7:f001 include:_spf.google.com ~all"
_dmarc	TXT	"v=DMARC1;p=none;rua=mailto:dmarc@johnbond.org;"
default._domainkey    TXT "v=DKIM1; t=y; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu2rmDcWQdyp2YU5sqcKLvH9gz6n2x7e0Oa7sXGVRsKJMQWes4eTXIgv1FHk+VL5Uz4kCkVmt8gZyW7f6UEfFFJ4MUS224dJLCngRRpDDAkGjkIMvTzmE3VngzE9gIBoxAzhy7FGaBiNi+wQv9u7DLR5jaIsJpCeMCWXyjdg/7pZm+qH8Dmo0+Umqjh/" "GDKUoyOANQkYhrJ5hkSYHIwV6paVDcCIauV7kkxlGQtlR8c0nhyxMCqsG3uvAidL0qgse6zH06Bw8KUCoDR9sPXCPaZyDupiQkCxdglsLcULF25uL1+eTdWxsG4qpguNFB1sOT/ggEl+kF2DB2zkdnE25UQIDAQAB"

$TTL 6h ; Set TTL for other RRsets to 6 hours
www A 67.205.10.42
