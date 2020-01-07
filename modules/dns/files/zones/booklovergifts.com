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
        MX      10 aspmx.l.google.com.
        MX      20 alt2.aspmx.l.google.com.
        MX      20 alt1.aspmx.l.google.com.
        MX      30 aspmx4.googlemail.com.
        MX      30 aspmx2.googlemail.com.
        MX      30 aspmx3.googlemail.com.
        MX      30 aspmx5.googlemail.com.
        TXT     "google-site-verification=W7g1XP1T90LDGBcNUgxik55BQjipfw72emW6U9vSstw"
        TXT     "google-site-verification=DLDn4CuM7ctewYutBrOjGG93SioNhQKM20oqtlbT2Qo"
        TXT     "google-site-verification=3osTVdHEIl8wCQJJPXRK3EO__UBuVfTReaw_5hfWUgw"

        A       23.227.38.32
www     CNAME   book-lover-gifts.myshopify.com.
