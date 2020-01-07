#
class dns (
    Array[String[3]] $zones,
    Stdlib::Filesource $zones_dir,
) {
    include knot
    $zones.each |String $zone| {
        knot::file{$zone:
            source => "${zones_dir}/${zone}",
        }
        knot::zone{$zone: }
    }
    ['iptables', 'ip6tables'].each |String $provider| {
        ['udp', 'tcp'].each |String $proto| {
            firewall {"101 DNS ${provider} ${proto}":
                proto    => $proto,
                dport    => 53,
                action   => 'accept',
                provider => $provider,
            }
        }
    }
}
