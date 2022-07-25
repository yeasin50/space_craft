extension EnumExtension on Enum {
  ///is this contains on [enums]
  bool isIn(List enums) {
    return enums.contains(this);
  }
}
