class twvault {
  postgresql::server::database { 'twvault':
    owner => 'twvault',
  }
}
