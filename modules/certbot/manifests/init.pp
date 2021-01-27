class certbot {
    ensure_packages(['certbot'])
    cron {'certbot_exim':
        command => '/usr/bin/certbot certonly --post-hook "systemctl restart exim4 dovecot"',
        minute  => 0,
        hour    => 11,
    }
    cron {'certbot_nel.johnbond.org':
        command => '/usr/bin/certbot certonly --apache -d nel.johnbond.org',
        minute  => 0,
        hour    => 12,
    }
    cron {'certbot_attackplanner.co.uk':
        command => '/usr/bin/certbot certonly --apache -d attackplanner.co.uk',
        minute  => 0,
        hour    => 13,
    }

}

