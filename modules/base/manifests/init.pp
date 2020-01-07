#
class base {
    $packages = [
        'vim',
        'git',
        'ruby-bundler',
        'facter',
        'puppet',
    ]
    ensure_packages($packages)
    file{'/etc/hostname':
        ensure  => file,
        content => "${facts['networking']['fqdn']}\n"
    }
    flle{'/etc/puppet/hiera.yaml':
        ensure  => file,
        content => file('base/hiera.yaml'),
    }
}
