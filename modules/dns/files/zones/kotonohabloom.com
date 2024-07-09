$TTL 1h ; Set TTL to one hour for all important RRsets

@	SOA	ns.johnbond.org. dns.johnbond.org. (
		2024070900 ; Serial
		1h ; Refresh
		10m ; Retry
		10d; Expire
		1h ; Negative
)
	NS	loki.johnbond.org.
	NS	ns1.he.net.

	MX	1 aspmx.l.google.com.
	MX	5 alt1.aspmx.l.google.com.
	MX	5 alt2.aspmx.l.google.com.
	MX	10 alt3.aspmx.l.google.com.
	MX	10 alt4.aspmx.l.google.com.

    A 67.205.2.212
    TXT "google-site-verification=d5GPcuQSylxdc9W56zy-oFRwLKSe1fDfGRjwb8N__lo"
    TXT "v=spf1 +mx ip4:206.189.25.239 ip6:2a03:b0c0:1:e0::4f7:f001 include:_spf.google.com ~all"
_dmarc	TXT	"v=DMARC1;p=none;rua=mailto:dmarc@johnbond.org;"
google._domainkey TXT "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAthlVXnTCh+2AcWPZSPUh6tX4GY2sfA08MNtnqieMxx/vVRVkrB1gAvEIS47NQ1wvqX9yECBpeIR9ebaY+hrlsyh1DdN7KyTae0hUACPVUjidDaKExz40ggL+Uv4osYmkpRcmvbbEGfQNiU9KZPit4fV1w2OBQyx5os7hEzi9PDOvGExSmyx8YNa0ohFDvnLU4wJABiaJzCzuyHdF3sR4d/od/H7/2icdBE7QlUDF1oTOGlQg17OTJ4LmYqtYZ9xKK0R3gSF7M50+9om5byv0qqiHdXshI2WdeVBQVRjd5ws/g2AXXBphx9IJdbAsJmM807xpcvlD+nM08OuF+ukWcwIDAQAB"
$TTL 5m ; Set TTL for other RRsets to 6 hours
www A 67.205.2.212
