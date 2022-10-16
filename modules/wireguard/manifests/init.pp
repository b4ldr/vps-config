# @summary set up wireguard
# @param private_key the private key
# @param public_key the public key
# @param ip_address the ip to listen on
# @param port the port to listen on
# @param keep_alive the PersistentKeepalive setting
# @param allowed_ips allowd ips
# @param endpoint_address the endpoint ip address
# @param endpoint_port the endpoint ip port
class wireguard (
  String                        $private_key,
  String                        $public_key,
  Stdlib::IP::Address           $ip_address       = '192.168.42.1/24',
  Integer                       $keep_alive       = 20,
  Stdlib::Port                  $port             = 51194,
  Stdlib::Port                  $endpoint_port    = 51194,
  Optional[Stdlib::IP::Address] $endpoint_address = undef,
  Optional[Stdlib::IP::Address] $allowed_ips      = undef,
) {
  ensure_packages(['wireguard'])
  firewall { '05_wireguard':
    proto  => 'udp',
    dport  => $port,
    action => 'accept',
  }
  $_allowed_ips = $allowed_ips ? {
    undef   => '',
    default => "AllowedIPs = ${allowed_ips}"
  }
  $_endpoint = $endpoint_address ? {
    undef   => '',
    default => "Endpoint = ${endpoint_address}:${endpoint_port}"
  }
  $config = @("config")
  [Interface]
  # TODO; possible the following is ony vlid for clients
  # PersistentKeepalive = ${keep_alive}
  Address = ${ip_address}
  ListenPort = ${port}
  PrivateKey = ${private_key}
  # TODO: we probably dont wont this
  SaveConfig = true
  ${_allowed_ips}
  ${_endpoint}
  | config
  file {
    default:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0400',
      notify => Service['wg-quick@wg0'];
    '/etc/wireguard':
      ensure => directory;
    '/etc/wireguard/wg0.conf':
      content => $config;
    '/etc/wireguard/privatekey':
      content => $private_key;
    '/etc/wireguard/publickey':
      content => $public_key;
  }
  service { 'wg-quick@wg0':
    ensure => 'running',
    enable => true,
  }
}
