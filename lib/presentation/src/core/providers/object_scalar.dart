import 'package:flutter/material.dart';

import 'user_setting.dart';


abstract class _Elements {
  /// full screen/view size, that will cover by app
  Size get screen;

  Size get playerShip;

  Size get enemyShip;

  /// prefer bullet Size(x,4x)
  Size get playerBullet;

  /// prefer bullet Size(x,4x)
  Size get enemyBullet;

  Size get healthBox;

  /// position movement duration.
  Duration get animationDuration;
}

/// define GameObject's scale, provide information about screen and element size
/// Singleton class
class GObjectSize implements _Elements {
  static final GObjectSize _instance = GObjectSize._privateConstructor();
  static GObjectSize get instatnce => _instance;
  GObjectSize._privateConstructor();

  _showErr() {
    assert(
      _screenSize != null,
      "You must call GObjectSize.init(size: x) first",
    );
  }

  static Size? _screenSize;

  static late double _minLenght;
  ///it will decide the object scale, min(Screen.height, screen.width)
  double get minLength => _minLenght;

  /// inital the screenSize, use to generate others elements size
  static void init({
    required Size size,
  }) {
    _screenSize = size;

    // can be use `math.min`
    size.height < size.width
        ? _minLenght = size.height
        : _minLenght = size.width;
  }

  @override
  Size get screen => _screenSize ?? _showErr();

  //todo: make responsive size
  @override
  Size get enemyShip {
    _showErr();
    const double _scale = .001;
    // asset's image 48x32
    return Size(
      48 * _minLenght * _scale,
      32 * _minLenght * _scale,
    );
  }

  /// ship size is depend on screen size [_minLenght * .075], min ship  Size(50, 50)
  @override
  Size get playerShip {
    // debugPrint("screen size: $screen");
    _showErr();
    const double _scale = .10;
    return Size(
      _minLenght * _scale,
      _minLenght * _scale,
    );
  }

  /// topPortion height factor
  /// to get bottom use `1-[topHeightFactor]`
  final double topHeightFactor = 0.35;

  final double topWidthFactor = .5;

  ///todo: create Settings for sensivity
  ///player movement px on keyboard action: [keyboardMovementHandler]
  double get movementRatio =>
      screen.width * .02 * UserSetting.instance.movementSensitivity;

  /// top part of player ship based on Paint, This fix expty space player enemy-collision
  Size get playerShipTopPart {
    return Size(
      playerShip.width * topWidthFactor,
      playerShip.height * topHeightFactor,
    );
  }

  /// body part except [playerShipTopPart]; to fix collision
  Size get playerShipBottomPart {
    return Size(
      playerShip.width,
      playerShip.height * (1 - topHeightFactor),
    );
  }

  @override
  Size get healthBox {
    // debugPrint("screen size: $screen");
    _showErr();
    const double _scale = .06;
    return Size(
      _minLenght * _scale,
      _minLenght * _scale,
    );
  }

  @override
  Size get enemyBullet {
    _showErr();
    const double _scale = .01;
    return Size(
      _minLenght * _scale,
      _minLenght * _scale,
    );
  }

  @override
  Size get playerBullet {
    _showErr();
    const double _scale = .013;
    return Size(
      _minLenght * _scale,
      _minLenght * _scale,
    );
  }

  @override
  Duration get animationDuration => const Duration(milliseconds: 50);
}
