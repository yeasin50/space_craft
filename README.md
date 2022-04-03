# SpaceCraft

A simple game, wanna impliment in flutter.

[Audio manager usung assets_audio_player](https://pub.dev/packages/assets_audio_player/example)

# Test branch
is it a good approach using final keyword, where I I have to update field 
```
class A {
  final int a;
  A({required this.a});
  A copyWith({int? a}) => A(a: a ?? this.a);
  // void update(int a) => this.a = a; // we cant being final
}

void main(List<String> args) {
  A a = A(a: 3);
  a = a.copyWith(a: 1); // this return new A class
  print(a.a);
}
```

where it can be simplified without final 
```
class A {
  int a;
  A({required this.a});
}

void main(List<String> args) {
  A a = A(a: 3);
  a.a = 1;
  print(a.a);
}
```
## TODO

- [ ] score based on EnemyShip
- [x] controll space on enemy generation
- [ ] create two shape for player collision
- [ ] controll generationRate
- [ ] bullet rotate effect
- [ ] replace `Positioned` with `Aling` widget
- [ ] rm unused assets

---

## ⚠ For game you should use [Flame package](https://pub.dev/packages/flame)

<!-- ## ⚠ Debuging is Much laggy, avoid debug statements on forEach loop -->

Thought It might be because we are changing a lot, but sometimes it's just happen because of print/debug statements.  
Now lets add Explosions Rives on it, Not sure about how it gonna perform.

---

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
