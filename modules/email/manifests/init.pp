#
class email (
    Stdlib::Unixpath $virtual_dir    = '/etc/exim4/virtual_dir',
    Stdlib::Unixpath $tls_cert       = '/etc/ssl/certs/imaps.johnbond.org.pem',
    Stdlib::Unixpath $tls_key        = '/etc/ssl/private/imaps.johnbond.org.key',
    Stdlib::Unixpath $dkim_key       = '/etc/ssl/private/dkim.key',
    Stdlib::Host     $qualify_domain = 'johnbond.org',
    Hash             $domains        = {},
) {
    ensure_packages(['exim4-daemon-heavy', 'procmail', 'dovecot-imapd', 'sasl2-bin'])
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
        content => template('email/dovecot.conf.erb'),
        notify  => Service['dovecot'],
    }
    group {'sasl':
        members => 'Debian-exim',
        require => Package['sasl2-bin', 'exim4-daemon-heavy'],
    }
    # TODO: puppeitise START=yes in /etc/default/saslauthd
    service {['exim4', 'dovecot', 'saslauthd']:
        ensure => running,
        enable => true,
    }
    ['iptables', 'ip6tables'].each |String $provider| {
        ['25', '143', '465', '587', '993'].each |String $port| {
            firewall {"102 email ${provider} ${port}":
                proto    => 'tcp',
                dport    => $port,
                action   => 'accept',
                provider => $provider,
            }
        }
    }
}
