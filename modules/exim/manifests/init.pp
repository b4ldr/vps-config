#
class exim (
    Stdlib::Unixpath $virtual_dir = '/etc/exim4/virtual_dir',
    Stdlib::Unixpath $tls_cert = '/etc/ssl/certs/imaps.johnbond.org.pem',
    Stdlib::Unixpath $tls_key = '/etc/ssl/private/imaps.johnbond.org.key',
    Stdlib::Unixpath $dkim_key = '/etc/ssl/private/dkim.key',
    Stdlib::Host $qualify_domain = 'johnbond.org'
) {
    ensure_packages(['exim4-daemon-heavy', 'procmail'])
    file { '/etc/exim4/exim4.conf':
        ensure  => file,
        group   => 'Debian-exim',
        mode    => '0440',
        content => template('exim/exim.conf.erb'),
    }
    file {$virtual_dir:
        ensure => directory,
        group  => 'Debian-exim',
        mode   => '0440',
    }
}
