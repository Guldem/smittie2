import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:smittie/components/interactabled_object.dart';

import 'components/chests.dart';
import 'components/player.dart';
import 'components/trees.dart';
import 'components/water.dart';

class SmittieGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  SmittieGame();

  final world = World();
  late final CameraComponent cameraComponent;

  Interactable? _interactableObject;
  late final HudButtonComponent chestButton;
  late final JoystickComponent joystick;
  late TiledComponent mapComponent;
  late Player smittie;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

    chestButton = HudButtonComponent(
        button: CircleComponent(radius: 30, paint: knobPaint),
        margin: const EdgeInsets.only(right: 40, bottom: 40),
        onPressed: () => _interactableObject?.interact(this));
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(32));

    final startPos = mapComponent.tileMap.getLayer<ObjectGroup>('Misc')!.objects.first;

    world.add(mapComponent);
    world.add(smittie = Player(joystick, position: Vector2(startPos.x, startPos.y)));
    world.addAll(
      mapComponent.tileMap.getLayer<ObjectGroup>('Pickups')!.objects.map(
            (e) => Chest(name: e.name.toLowerCase(), position: Vector2(e.x, e.y), size: Vector2(e.width, e.height)),
          ),
    );
    world.addAll(Trees.fromObjectLayer(mapComponent.tileMap.getLayer<ObjectGroup>('Trees')!.objects));
    world.addAll(Waters.fromObjectLayer(mapComponent.tileMap.getLayer<ObjectGroup>('Waters')!.objects));

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.zoom = 5;
    cameraComponent.follow(smittie);

    addAll([cameraComponent, world, joystick]);
  }

  void closeMenu(String chestId) {
    print('closing $chestId');
    overlays.remove(chestId);
  }

  void showChestButton(Interactable interactableObject) {
    if (!contains(chestButton)) {
      _interactableObject = interactableObject;
      add(chestButton);
    }
  }

  void hideChestButton() {
    if (contains(chestButton)) {
      _interactableObject = null;
      remove(chestButton);
    }
  }
}
