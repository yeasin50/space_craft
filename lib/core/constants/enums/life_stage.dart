enum LifeStage {
  baby(Duration(seconds: 1)),
  young(Duration(seconds: 2)),
  old(Duration(seconds: 1)),
  deathBed(Duration(seconds: 1)),
  dead(Duration());

  final Duration duration;
  const LifeStage(this.duration);
}
