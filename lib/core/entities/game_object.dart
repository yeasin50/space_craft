import 'package:flutter/material.dart';
import 'package:vector2/vector2.dart';

  
 
/// base Object of this game
abstract class GameObject {
  Vector2 get position;
  Size get size;
  Color get color;
}
