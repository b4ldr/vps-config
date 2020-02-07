type Irssi::Ignore = Struct[{
    level     => Optional[Array[Enum['ALL', 'JOINS', 'QUITS', 'NO_ACT']]],
    mask      => Optional[String[1]],
    pattern   => Optional[String[1]],
    excptions => Optional[Boolean],
    regexp    => Optional[Boolean],
}]
