#
class email (
    Stdlib::Unixpath $virtual_dir    = '/etc/exim4/virtual_dir',
    Stdlib::Unixpath $tls_cert       = '/etc/ssl/certs/imaps.johnbond.org.pem',
    Stdlib::Unixpath $tls_key        = '/etc/ssl/private/imaps.johnbond.org.key',
    Stdlib::Unixpath $dkim_key       = '/etc/ssl/private/dkim.key',
    Stdlib::Host     $qualify_domain = 'johnbond.org',
    Hash             $domains        = {},
) {
    ensure_packages(['exim4-daemon-heavy', 'procmail', 'dovecot-imapd'])
    file { '/etc/exim4/exim4.conf':
        ensure  => file,
        group   => 'Debian-exim',
        mode    => '0440',
        content => template('email/exim.conf.erb'),
        notify  => Service['exim4'],
    }
    file {$virtual_dir:
        ensure  => directory,
        group   => 'Debian-exim',
        mode    => '0440',
        recurse => true,
        purge   => true,
    }
    $domains.each |String $domain, Hash $config| {
        $content = $config.has_key('aliases') ? {
            true    => $config['aliases'].reduce('') |$memo, $alias| {
                "${memo}\n${alias[0]}: ${alias[1]}"
            },
            default => '',
        }
        file {"${virtual_dir}/${domain}":
            ensure  => file,
            group   => 'Debian-exim',
            mode    => '0440',
            content => $content,
            notify  => Service['exim4'],
        }
    }
    file {'/etc/dovecot/local.conf':
        ensure  => file,
        content => template('dovecot.conf.erb'),
        notify  => Service['dovecot'],
    }
    service {['exim4', 'dovecot']:
        ensure => running,
        enable => true,
    }

}
