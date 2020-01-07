node 'loki.johnbond.org' {
    include base
    include my_fw::pre
    include firewall
    include my_fw::post
    include knot
    firewall {'101 DNS ipv4':
        proto   => 'all',
        dport   => 53,
        actions => 'accept',
    }
    firewall {'101 DNS ipv6':
        proto    => 'all',
        dport    => 53,
        actions  => 'accept',
        provider => 'ip6tables',
    }
}
