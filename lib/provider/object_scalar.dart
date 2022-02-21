import 'dart:ui';

/// define GameObject's scale, provide information about screen and element size
/// Singleton class
class ObjectScalar {
  static final ObjectScalar _instance = ObjectScalar._privateConstructor();
  static ObjectScalar get instatnce => _instance;
  ObjectScalar._privateConstructor();

  _showErr() {
    assert(
      _screenSize == null,
      "You must call ObjectScalar.init(size: x) first",
    );
  }

  Size? _screenSize;

  /// inital the screenSize, use to generate others elements size
  void init({required Size size}) => _screenSize = size;

  /// screen size
  Size get screenSize => _screenSize ?? _showErr();

  //todo: create object scaller
}
