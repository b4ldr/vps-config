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
    cron { 'puppet-apply':
        ensure  => present,
        minute  => 5,
        command => '/usr/local/bin/puppet-apply',
        require => File['/usr/local/bin/puppet-apply'],
    }
    $users.each |String $user, Hash $config| {
        user{$user:
            * => $config['user'],
        }
        ssh_authorized_key{"${user} ssh key":
            user => $user,
            *    => $config['ssh_authorized_key'],
        }
        file{"/home/${user}":
            ensure  => directory,
            source  => "puppet:///modules/base/users/${user}",
            mode    => '0600',
            recurse => 'remote',
        }
    }
}
