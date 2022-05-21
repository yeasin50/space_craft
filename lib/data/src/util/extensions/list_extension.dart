extension ListExtension<T> on List<T> {
  /// remove `List<T>` from current `List<T>`
  void removeAll(List<T> newItems) {
    for (final item in newItems) {
      removeWhere((element) => element == item);
    }
  }

  // /// remove `List<T>` from current `List<T>`
  // void addAll(List<T> newItems) {
  //   for (final item in newItems) {
  //     removeWhere((element) => element == item);
  //   }
  // }
}
