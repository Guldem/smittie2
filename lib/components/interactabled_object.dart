import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:smittie/smittie_game.dart';

import 'collision_poly_object.dart';

abstract interface class Interactable extends PositionComponent {
  void interact(SmittieGame game);
}

abstract class InteractableObject extends SpriteAnimationComponent implements Interactable, Collidable {
  InteractableObject({super.position, super.size});

  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final defaultPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..position = position
      ..size = size
      ..collisionType = CollisionType.passive
      ..paint = defaultPaint
      ..renderShape = true;

    add(hitbox);
  }

  void interact(SmittieGame game);
}
