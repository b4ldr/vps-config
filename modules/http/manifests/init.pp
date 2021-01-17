#
class http (
    Hash             $vhosts,
    Stdlib::Unixpath $docroot_base = '/srv/http',
    Boolean          $dumpio       = false,
){
    file {$docroot_base:
        ensure => directory,
    }
    include apache
    if $dumpio {
        include apache::mod::dumpio
    }
    $vhosts.each |$vhost, $config| {
        if $config.has_key('headers') {
            $headers = $config['headers'].map |$header| {
                $value = $header[1] ? {
                    String  => $header[1],
                    default => $header[1].to_json(),
                }.regsubst('"', '\\"', 'G')
                "set ${header[0]} \"${value}\""
            }
        } else {
            $headers = []
        }
        $default = {
            'docroot' => "${docroot_base}/${vhost}",
            'port'    => '80',
            'headers' => $headers,
        }
        $_config = $default + $config['apache']
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
        ['80', '443'].each |String $port| {
            firewall {"103 HTTP ${provider} ${port}":
                proto    => 'tcp',
                dport    => $port,
                action   => 'accept',
                provider => $provider,
            }
        }
    }
}
