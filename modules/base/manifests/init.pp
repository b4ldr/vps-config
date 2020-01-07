#
class base (
    Array[String] $packages,
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
}
