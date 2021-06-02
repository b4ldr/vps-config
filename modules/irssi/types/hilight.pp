type Irssi::Hilight = Struct[{
  highlight => Optional[Enum['nick', 'word', 'line']],
  mask      => Optional[Boolean],
  full      => Optional[Boolean],
  matchcase => Optional[Boolean],
  regexp    => Optional[Boolean],
  servertag => Optional[String[1]],
  color     => Optional[Pattern[/%\w/]],
  priority  => Optional[Integer[1]],
  network   => Optional[String[1]],
  channels  => Optional[Array[String[1]]],
}]
