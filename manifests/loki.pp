node 'loki.johnbond.org' {
    include base
    include my_fw::pre
    include firewall
    include my_fw::post
    include knot
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
