type Irssi::Hilight = Struct[{
    nick      => Boolean,
    word      => Boolean,
    servertag => Optional[String[1]],
    color     => Optional[Pattern[/%\w/]],
    matchcase => Optional[Boolean],
    channels  => Optional[Array[String[1]]],
}]
