class my_fw::post {
  firewall { '999 drop all':
    proto  => 'all',
    jump   => 'reject',
    before => undef,
  }
  firewall { '999 drop all ipv6':
    proto    => 'all',
    jump     => 'reject',
    before   => undef,
    protocol => 'ip6tables',
  }
}
