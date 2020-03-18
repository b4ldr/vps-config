# @summary install https://github.com/insomniacslk/irc-slack
class irc_slack (
    Stdlib::Unixpath $source_dir = '/usr/local/src/irc-slack',
    Stdlib::Unixpath $home_dir   = '/var/lib/irc-slack',
    String           $user       = 'irc-slack',
) {
    $source = 'https://github.com/insomniacslk/irc-slack.git'
    ensure_packages(['golang'])
    user {$user:
        ensure     => present,
        home       => $home_dir,
        managehome => true,
        shell      => '/usr/sbin/nologin',
        system     => true,
    }
    file{$source_dir:
        ensure => directory,
        owner  => $user,
    }
    vcsrepo {$source_dir:
        ensure   => present,
        source   => $source,
        provider => git,
        user     => $user,
        require  => File[$source_dir],
    }
    exec{'go build':
        path        => '/usr/bin',
        user        => $user,
        cwd         => $source_dir,
        environment => [
            "GOCACHE=${home_dir}/.cache/go-build",
            "GOPATH=${home_dir}/go",
        ],
        creates     => "${source_dir}/irc-slack",
        subscribe   => Vcsrepo[$source_dir],
    }
    file{'/usr/local/bin/irc-slack':
        ensure  => link,
        target  => "${source_dir}/irc-slack",
        require => Exec['go build']
    }
}