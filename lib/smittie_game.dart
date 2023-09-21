import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:smittie/components/objects/interactabled_object.dart';

import 'components/objects/chests.dart';
import 'components/objects/trees.dart';
import 'components/player.dart';
import 'components/objects/water.dart';
import 'core/colors.dart';
import 'core/text_style.dart';

class SmittieGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  SmittieGame();

  late final world = World();
  late final CameraComponent cameraComponent;

  Interactable? _interactableObject;
  late final HudButtonComponent actionButton;
  late final JoystickComponent joystick;
  late TiledComponent mapComponent;
  TextComponent? textBoxComponent;
  late Player smittie;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    actionButton = HudButtonComponent(
      button: CircleComponent(radius: 30, paint: SColors.knobPaint),
      margin: const EdgeInsets.only(right: 40, bottom: 40),
      onPressed: () => _interactableObject?.interact(this),
    );
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: SColors.knobPaint),
      background: CircleComponent(radius: 100, paint: SColors.backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(32));

    final startPos = mapComponent.tileMap.getLayer<ObjectGroup>('Misc')!.objects.first;
    smittie = Player(joystick, position: Vector2(startPos.x, startPos.y));

    world.addAll(
      [
        mapComponent,
        smittie,
        ...mapComponent.tileMap.getLayer<ObjectGroup>('Pickups')!.objects.map(
              (e) => Chest(name: e.name.toLowerCase(), position: Vector2(e.x, e.y), size: Vector2(e.width, e.height)),
            ),
        ...Trees.fromObjectLayer(mapComponent.tileMap.getLayer<ObjectGroup>('Trees')!.objects),
        ...Waters.fromObjectLayer(mapComponent.tileMap.getLayer<ObjectGroup>('Waters')!.objects),
      ],
    );

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.zoom = 3;
    cameraComponent.follow(smittie);

    addAll([cameraComponent, world, joystick, actionButton]);
  }

  void closeMenu(String chestId) {
    overlays.remove(chestId);
  }

  void showChestButton(Interactable interactableObject) {
    if (textBoxComponent == null) {
      _interactableObject = interactableObject;
      textBoxComponent = TextComponent(
        text: interactableObject.action,
        textRenderer: TextPaint(
          style: defaultTextStyle,
        ),
        position: actionButton.position - Vector2(15, 28),
      );
      add(textBoxComponent!);
    }
  }

  void hideChestButton() {
    if (textBoxComponent != null && contains(textBoxComponent!)) {
      remove(textBoxComponent!);
      _interactableObject = null;
      textBoxComponent = null;
    }
  }
}
