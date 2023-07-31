import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

abstract interface class Collidable extends PositionComponent {}

class CollisionPolygonObject extends PositionComponent implements Collidable {
  CollisionPolygonObject({required this.vertices, super.position, super.size});

  final List<Vector2> vertices;
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke;
    hitbox = PolygonHitbox(vertices)
      ..collisionType = CollisionType.passive
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    return super.onLoad();
  }
}
