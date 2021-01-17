#
class http (
    Hash             $vhosts,
    Stdlib::Unixpath $docroot_base = '/srv/http',
){
    file {$docroot_base:
        ensure => directory,
    }
    include apache
    $vhosts.each |$vhost, $config| {
        if $config.has_key('headers') {
            $config['headers'].map |$header| {
                $value = $header[1] ? {
                    String  => $header[1],
                    default => $header[1].to_json(),
                }
                "set ${header[0]} ${value}"
            }
        } else {
            $headers = []
        }
        $default = {
            'docroot' => "${docroot_base}/${vhost}",
            'port'    => '80',
            'headers' => $headers,
        }
        $_config = $config['apache'] + $default
        if $config.has_key('git_source') {
            vcsrepo {$_config['docroot']:
                ensure   => latest,
                provider => git,
                source   => $config['git_source'],
            }
        } else {
            file {$_config['docroot']:
                ensure => directory,
            }
        }
        apache::vhost{ $vhost:
            * => $_config,
        }
    }
    ['iptables', 'ip6tables'].each |String $provider| {
        ['80'].each |String $port| {
            firewall {"103 HTTP ${provider} ${port}":
                proto    => 'tcp',
                dport    => $port,
                action   => 'accept',
                provider => $provider,
            }
        }
    }
}
