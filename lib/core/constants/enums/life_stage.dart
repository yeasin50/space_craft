enum ShipState {
  ///* idle after hit or healed
  initial(Duration()),

  ///* idle after hit or healed
  idle(Duration()),

  ///* initial
  glitch(Duration(seconds: 1)),

  ///* healed => increase health
  healed(Duration(seconds: 2)),

  ///* Dead => on haven
  dead(Duration());

  final Duration duration;
  const ShipState(this.duration);
}
