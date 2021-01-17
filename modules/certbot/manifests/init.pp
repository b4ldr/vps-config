class certbot {
    ensure_packages(['certbot'])
    cron {'certbot_exim':
        command => "/usr/bin/certbot certonly --post-hook 'systemctl restart exim4 dovecot'",
        minute  => 0,
        hour    => 11,
    }
    cron {'certbot_apache':
        command => "/usr/bin/certbot certonly --apache -d nel.johnbond.org -d attackplanner.co.uk",
        minute  => 0,
        hour    => 12,
    }

}

