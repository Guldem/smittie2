import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smittie/components/interactabled_object.dart';
import 'package:smittie/components/player_utility_hitbox.dart';
import 'package:smittie/smittie_game.dart';

import 'collision_poly_object.dart';

class Player extends SpriteAnimationComponent with HasGameRef<SmittieGame>, KeyboardHandler, CollisionCallbacks {
  Player(this.joystick, {super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(16),
          anchor: Anchor.center,
        );

  static const double speed = 50;
  final Vector2 velocity = Vector2.zero();
  final JoystickComponent joystick;
  late final Transform2D _lastTransform = transform.clone();
  late final SpriteAnimation rightAnimation;
  late final SpriteAnimation leftAnimation;
  late final SpriteAnimation upAnimation;
  late final SpriteAnimation downAnimation;
  late final SpriteAnimation idleAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    rightAnimation = await gameRef.loadSpriteAnimation(
      'goat/spritesheet-right.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: true,
      ),
    );
    leftAnimation = await gameRef.loadSpriteAnimation(
      'goat/spritesheet-left.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: true,
      ),
    );
    upAnimation = await gameRef.loadSpriteAnimation(
      'goat/spritesheet-back.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: true,
      ),
    );

    downAnimation = await gameRef.loadSpriteAnimation(
      'goat/spritesheet-front.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: true,
      ),
    );
    idleAnimation = await gameRef.loadSpriteAnimation(
      'goat/spritesheet-front.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: true,
      ),
    );

    animation = idleAnimation;
    // animation = await gameRef.loadSpriteAnimation(
    //   'ember.png',
    //   SpriteAnimationData.sequenced(
    //     amount: 3,
    //     textureSize: Vector2.all(16),
    //     stepTime: 0.15,
    //   ),
    // );
    final defaultPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke;
    add(PlayerUtilityHitbox(size: size, position: _lastTransform.offset));
    add(CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (activeCollisions.every((element) => element is! Collidable)) {
      _lastTransform.setFrom(transform);
      if (!joystick.delta.isZero()) {
        setDirectionAnimation();
        position.add(joystick.relativeDelta * speed * dt);
      } else if (!velocity.isZero()) {
        final deltaPosition = velocity * (speed * dt);
        position.add(deltaPosition);
      }else {
        animation = idleAnimation;
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Collidable) {
      transform.setFrom(_lastTransform);
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;

    velocity.x = 0;
    velocity.y = 0;
    velocity.x +=
        (keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft)) ? -1 : 0;
    velocity.x +=
        (keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight)) ? 1 : 0;

    velocity.y +=
        (keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.arrowUp)) ? -1 : 0;
    velocity.y +=
        (keysPressed.contains(LogicalKeyboardKey.keyS) || keysPressed.contains(LogicalKeyboardKey.arrowDown)) ? 1 : 0;

    if (velocity.x == -1) {
      animation = leftAnimation;
    } else if (velocity.x == 1) {
      animation = rightAnimation;
    } else if (velocity.y == 1) {
      animation = downAnimation;
    } else if (velocity.y == -1) {
      animation = upAnimation;
    } else {
      animation = idleAnimation;
    }
    return false;
  }

  void setDirectionAnimation() {
    switch (joystick.direction) {
      case JoystickDirection.up:
        animation = upAnimation;
        break;
      case JoystickDirection.down:
        animation = downAnimation;
        break;
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
      case JoystickDirection.left:
        animation = leftAnimation;
        break;
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
      case JoystickDirection.right:
        animation = rightAnimation;
        break;
      case JoystickDirection.idle:
        animation = idleAnimation;
        break;
    }
  }
}
