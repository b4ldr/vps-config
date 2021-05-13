$TTL 3600	; 1 hour
@	IN SOA	ns.johnbond.org. dns.johnbond.org. (
				2020020601 ; serial
				3600       ; refresh (1 hour)
				600        ; retry (10 minutes)
				864000     ; expire (1 week 3 days)
				3600       ; minimum (1 hour)
				)
			NS	loki.johnbond.org.
			NS	ns1.he.net.
			MX	10 loki.johnbond.org.
            A 206.189.25.239
            AAAA 2a03:b0c0:1:e0::4f7:f001
$TTL 21600	; 6 hours
www IN A 206.189.25.239
www IN AAAA 2a03:b0c0:1:e0::4f7:f001
