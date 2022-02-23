import 'dart:ui';

abstract class _Elements {
  /// full screen/view size, that will cover by app
  Size get screen;

  Size get playerShip;

  Size get enemyShip;

  /// prefer bullet Size(x,4x)
  Size get playerBullet;

  /// prefer bullet Size(x,4x)
  Size get enemyBullet;
}

/// define GameObject's scale, provide information about screen and element size
/// Singleton class
class GObjectSize implements _Elements {
  static final GObjectSize _instance = GObjectSize._privateConstructor();
  static GObjectSize get instatnce => _instance;
  GObjectSize._privateConstructor();

  _showErr() {
    assert(
      _screenSize == null,
      "You must call ObjectScalar.init(size: x) first",
    );
  }

  Size? _screenSize;

  /// inital the screenSize, use to generate others elements size
  void init({required Size size}) => _screenSize = size;

  @override
  Size get screen => _screenSize ?? _showErr();

  //todo: make responsive
  @override
  Size get enemyShip => const Size(24, 24);

  @override
  Size get playerShip => const Size(50, 50);

  @override
  Size get enemyBullet => const Size(5, 5 * 4);

  @override
  Size get playerBullet => const Size(5, 5 * 4);
}
