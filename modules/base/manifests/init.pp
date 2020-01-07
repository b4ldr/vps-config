#
class base (
    Array[String] $packages,
    Hash[String, Hash] $users,
){
    ensure_packages($packages)
    file{'/etc/hostname':
        ensure  => file,
        content => "${facts['networking']['fqdn']}\n",
    }
    file{'/etc/puppet/hiera.yaml':
        ensure  => file,
        content => file('base/hiera.yaml'),
    }
    file{'/usr/local/bin/puppet-apply':
        ensure  => file,
        content => file('base/puppet-apply'),
        mode    => '0550',
    }
    $users.each |String $user, Hash $config| {
        user{$user:
            * => $config['user'],
        }
        ssh_authorized_key{"${user} ssh key":
            user => $user,
            *    => $config['ssh_authorized_key'],
        }
    }
}
