import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:smittie/smittie_game.dart';

import '../../core/colors.dart';
import 'collision_poly_object.dart';

abstract interface class Interactable extends PositionComponent {
  void interact(SmittieGame game, void Function() onComplete);

  bool get interactable;

  String get action;
}

abstract class InteractableObject extends SpriteAnimationComponent implements Interactable, Collidable {
  InteractableObject({super.position, super.size});

  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    hitbox = RectangleHitbox()
      ..position = position
      ..size = size
      ..collisionType = CollisionType.passive
      ..paint = SColors.defaultPaint
      ..renderShape = kDebugMode;

    add(hitbox);
  }
}
