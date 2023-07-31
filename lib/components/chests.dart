import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:smittie/components/interactabled_object.dart';
import 'package:smittie/smittie_game.dart';

class Chest extends InteractableObject with HasGameRef<SmittieGame> {
  Chest({required this.name, super.position, super.size});

  final String name;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'chest.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(16),
        stepTime: 0.15,
      ),
    );
  }

  @override
  void interact(SmittieGame game) {
    game.overlays.add(name);
  }
}

enum ChestAnimals {
  beaver('assets/images/animal_stickers/Beaver.png'),
  elephant('assets/images/animal_stickers/Beaver.png'),
  ape('assets/images/animal_stickers/Beaver.png'),
  chicken('assets/images/animal_stickers/Beaver.png'),
  cow('assets/images/animal_stickers/Beaver.png'),
  dog('assets/images/animal_stickers/Beaver.png'),
  duck('assets/images/animal_stickers/Beaver.png'),
  sheep('assets/images/animal_stickers/Beaver.png'),
  pig('assets/images/animal_stickers/Beaver.png'),
  fox('assets/images/animal_stickers/Beaver.png'),
  lion('assets/images/animal_stickers/Lion.png');

  const ChestAnimals(this.asset);

  final String asset;
}
