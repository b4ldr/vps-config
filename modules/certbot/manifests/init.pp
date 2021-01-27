class certbot {
    ensure_packages(['certbot'])
    cron {'certbot_exim':
        command => '/usr/bin/certbot renew',
        minute  => 0,
        hour    => 11,
    }

}

