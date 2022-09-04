import '../../entities/entities.dart';

/// check collision between [GameObject]
bool collisionChecker({
  required GameObject a,
  required GameObject b,
}) {
  if (b.position.dX + b.size.width >= a.position.dX &&
      b.position.dX <= a.position.dX + a.size.width &&
      b.position.dY <= a.position.dY + a.size.height &&
      b.position.dY + b.size.height >= a.position.dY) {
    return true;
  }
  return false;
}
