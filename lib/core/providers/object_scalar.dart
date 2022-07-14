import 'package:flutter/material.dart';

import '../entities/user_setting.dart';

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
  static GObjectSize get instance => _instance;
  GObjectSize._privateConstructor();

  _showErr() {
    assert(() {
      if (_screenSize == null) {
        throw FlutterError.fromParts([
          ErrorSummary("GObjectSize hasn't initialized"),
          ErrorDescription("`screenSize` and `minLength` can not be null."),
          ErrorHint(
              "Call `GObjectSize.init(size: x)` before using $GObjectSize\n")
        ]);
      }
      return true;
    }());
  }

  static Size? _screenSize;

  static double? _minLength;

  ///it will decide the object scale, min(Screen.height, screen.width)
  double get minLength => _minLength ?? _showErr();

  /// initial the screenSize, use to generate others elements size
  static void init({
    required Size size,
  }) {
    _screenSize = size;

    // can be use `math.min`
    size.height < size.width
        ? _minLength = size.height
        : _minLength = size.width;
  }

  @override
  Size get screen => _screenSize ?? _showErr();

  //todo: make responsive size
  @override
  Size get enemyShip {
    const double scale = .001;
    // asset's image 48x32
    return Size(
      48 * minLength * scale,
      32 * minLength * scale,
    );
  }

  /// ship size is depend on screen size [_minLength * .075], min ship  Size(50, 50)
  @override
  Size get playerShip {
    const double scale = .10;
    return Size(
      minLength * scale,
      minLength * scale,
    );
  }

  /// topPortion height factor
  /// to get bottom use `1-[topHeightFactor]`
  final double topHeightFactor = 0.35;

  final double topWidthFactor = .5;

  ///todo: create Settings for sensitivity
  ///player movement px on keyboard action: [keyboardMovementHandler]
  double get movementRatio =>
      screen.width * .02 * DefaultUserSetting.instance.movementSensitivity;

  /// top part of player ship based on Paint, This fix empty space player enemy-collision
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
    const double scale = .06;
    return Size(
      minLength * scale,
      minLength * scale,
    );
  }

  @override
  Size get enemyBullet {
    const double scale = .01;
    return Size(
      minLength * scale,
      minLength * scale,
    );
  }

  @override
  Size get playerBullet {
    const double scale = .013;
    return Size(
      minLength * scale,
      minLength * scale,
    );
  }

  @override
  Duration get animationDuration => const Duration(milliseconds: 50);
}
