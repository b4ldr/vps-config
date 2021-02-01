node 'loki.johnbond.org' {
    include base
    include my_fw::pre
    include firewall
    include my_fw::post
    include certbot
    include dns
    include email
    include http
    include irssi
}
