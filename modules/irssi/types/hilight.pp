type Irssi::Hilight = Struct[{
  highlight => Optional[Enum['nick', 'word', 'line']],
  match     => Optional[Enum['mask', 'full', 'matchcase', 'regexp']],
  servertag => Optional[String[1]],
  color     => Optional[Pattern[/%\w/]],
  network   => Optional[String[1]],
  channels  => Optional[Array[String[1]]],
}]
