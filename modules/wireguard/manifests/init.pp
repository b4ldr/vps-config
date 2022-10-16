# @summary set up wireguard
# @param private_key the private key
# @param public_key the public key
# @param ip_address the ip to listen on
# @param port the port to listen on
class wireguard (
  String              $private_key,
  String              $public_key,
  Stdlib::IP::Address $ip_address = $facts['networking']['ip'],
  Stdlib::Port        $port       = 51194
) {
  ensure_packages(['wireguard'])
  firewall { '05_wireguard':
    proto  => 'udp',
    dport  => $port,
    action => 'accept',
  }
  $config = @("config")
  [Interface]
  Address = ${ip_address}
  ListenPort = ${port}
  PrivateKey = ${private_key}
  # TODO: we probably dont wont this
  SaveConfig = true
  | config
  file {
    default:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0400';
    '/etc/wireguard':
      ensure => directory;
    '/etc/wireguard/wg0.conf':
      content => $config;
    '/etc/wireguard/privatekey':
      content => $private_key;
    '/etc/wireguard/publickey':
      content => $public_key;
  }
}
