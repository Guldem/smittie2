import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../core/colors.dart';
import '../smittie_game.dart';
import 'objects/interactabled_object.dart';

class PlayerUtilityHitbox extends CircleHitbox with HasGameRef<SmittieGame> {
  PlayerUtilityHitbox({required Vector2 size, required Vector2 position})
      : super.relative(2, parentSize: size, position: position);

  @override
  Future<void> onLoad() async {
    triggersParentCollision = false;
    isSolid = true;
    paint = SColors.defaultPaint;
    renderShape = kDebugMode;
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, ShapeHitbox other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other.hitboxParent is Interactable && (other.hitboxParent as Interactable).interactable) {
      gameRef.showChestButton(other.hitboxParent as Interactable);
    }
  }

  @override
  void onCollisionEnd(ShapeHitbox other) {
    if (other.hitboxParent is Interactable) {
      gameRef.hideChestButton();
    }
    super.onCollisionEnd(other);
  }
}
