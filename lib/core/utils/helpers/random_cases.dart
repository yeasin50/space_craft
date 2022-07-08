import 'dart:math' show Random;

final _random = Random();

///* Generates a positive random integer uniformly distributed on the range
///* from [min], inclusive, to [max], exclusive.
int next({required int min, required int max}) =>
    min + _random.nextInt(max - min);
