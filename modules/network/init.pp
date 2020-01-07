class network {
    file{'/etc/hostname':
        ensure  => file,
        content => "${facts['networking']['fqdn']}\n"
    }
}
