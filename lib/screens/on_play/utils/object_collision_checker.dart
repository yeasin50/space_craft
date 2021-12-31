import 'package:space_craft/model/model.dart';

/// check collision between ship and bullet
bool collisionChecker({
  required GameObject a,
  required GameObject b,
}) {
  //todo: include bullet width
  if (b.position.dX >= a.position.dX &&
      b.position.dX <= a.position.dX + a.size.width &&
      b.position.dY <= a.position.dY + a.size.height &&
      b.position.dY >= a.position.dY) {
    return true;
  }
  return false;
}
