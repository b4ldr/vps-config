# @summary install irssi user configueration
define irssi::user_config (
    Hash[String[1], Irssi::Server]            $servers,
    String[1]                                 $real_name                  = $name,
    String[1]                                 $user_name                  = $name,
    String[1]                                 $nick                       = $name,
    Boolean                                   $recode                     = true,
    Boolean                                   $recode_autodetect_utf8     = true,
    String[1]                                 $recode_fallback            = 'UTF-8',
    String[1]                                 $recode_out_default_charset = 'UTF-8',
    Boolean                                   $recode_transliterate       = true,
    String[1]                                 $theme                      = 'fear2',
    String[1]                                 $term_charset               = 'utf-8',
    Optional[Stdlib::Unixpath]                $home_path                  = "/home/${name}",
    Optional[Hash[String[1],String[1]]]       $extra_aliases              = {},
    Optional[Hash[String[1],String]]          $perl_script_config         = {},
    Optional[Array[Irssi::Ignore]]            $ignores                    = [],
    Optional[Hash[String[1], Irssi::Hilight]] $hilights                   = {},
) {
    include irssi
    $aliases = $extra_aliases + $irssi::default_aliases
    file { "${home_path}/.irssi":
        ensure => directory,
        owner  => $name,
    }
    file { "${home_path}/.irssi/${theme}.theme":
        ensure  => file,
        content => file("irssi/${theme}.theme"),
        owner   => $name,
        mode    => '0600',
    }
    file { "${home_path}/.irssi/config":
        ensure  => file,
        content => template('irssi/config.erb'),
        owner   => $name,
        mode    => '0600',
    }
}
