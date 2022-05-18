extension StringExtension on String {
  String get sentenceCase {
    if (isEmpty) {
      return "";
    }
    final firstChar = toString().split("").first;
    return firstChar.toUpperCase() + replaceFirst(firstChar, "");
  }
}
