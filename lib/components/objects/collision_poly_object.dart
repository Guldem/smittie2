import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../core/colors.dart';


abstract interface class Collidable extends PositionComponent {}

class CollisionPolygonObject extends PositionComponent implements Collidable {
  CollisionPolygonObject({required this.vertices, super.position, super.size});

  final List<Vector2> vertices;
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    hitbox = PolygonHitbox(vertices)
      ..collisionType = CollisionType.passive
      ..paint = SColors.defaultPaint
      ..renderShape = kDebugMode;
    add(hitbox);
    return super.onLoad();
  }
}
