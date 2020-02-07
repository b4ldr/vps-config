# @summary instal irssi and scripts
class irssi (
    Hash                       $user_configs,
    Hash[String[1], String[1]] $default_aliases,
) {
    ensure_packages(['irssi', 'irssi-scripts'])
    $user_configs.each |String $user, Hash $config| {
        irssi::user_config {$user:
            * => $config,
        }
    }

}
