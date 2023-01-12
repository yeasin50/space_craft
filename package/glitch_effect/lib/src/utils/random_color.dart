part of glitch_effect;

Color getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.orange,
    ][math.Random().nextInt(4)];
