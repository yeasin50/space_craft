import 'dart:collection';

/// [List] with `removeAll` method
class CustomList<T> extends ListBase<T> {
  late final List<T> _l;

  CustomList([List<T>? t]) : _l = t ?? [];

  @override
  T operator [](int index) => _l[index];

  @override
  void operator []=(int index, T value) => _l[index] = value;

  @override
  int get length => _l.length;

  @override
  set length(int newLength) => _l.length = newLength;

  void removeAll(List<T> newItems) {
    for (final item in newItems) {
      _l.removeWhere((element) => element == item);
    }
  }
}
