import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frummeltje/components/objects/interactabled_object.dart';

import 'components/objects/chest_animals.dart';
import 'components/objects/chests.dart';
import 'components/objects/trees.dart';
import 'components/player.dart';
import 'components/objects/water.dart';
import 'core/colors.dart';
import 'core/text_style.dart';

class FrummeltjeGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  FrummeltjeGame();

  @override
  late final world = World();
  late final CameraComponent cameraComponent;

  Interactable? _interactableObject;
  late final HudButtonComponent actionButton;
  late final JoystickComponent joystick;
  late TiledComponent mapComponent;
  TextComponent? textBoxComponent;
  TextComponent? countTextBoxComponent;
  late Player frummeltje;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    actionButton = HudButtonComponent(
      button: CircleComponent(radius: 30, paint: SColors.knobPaint),
      margin: const EdgeInsets.only(right: 40, bottom: 40),
      onPressed: () => _interactableObject?.interact(this, updateCount),
    );
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: SColors.knobPaint),
      background: CircleComponent(radius: 100, paint: SColors.backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(32));

    final startPos = mapComponent.tileMap.getLayer<ObjectGroup>('Misc')!.objects.first;
    frummeltje = Player(joystick, position: Vector2(startPos.x, startPos.y));

    world.addAll(
      [
        mapComponent,
        frummeltje,
        ...mapComponent.tileMap.getLayer<ObjectGroup>('Pickups')!.objects.map(
              (e) => Chest(name: e.name.toLowerCase(), position: Vector2(e.x, e.y), size: Vector2(e.width, e.height)),
            ),
        ...Trees.fromObjectLayer(mapComponent.tileMap.getLayer<ObjectGroup>('Trees')!.objects),
        ...Waters.fromObjectLayer(mapComponent.tileMap.getLayer<ObjectGroup>('Waters')!.objects),
      ],
    );

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.zoom = 3;
    cameraComponent.follow(frummeltje);

    addAll([cameraComponent, world, joystick, actionButton]);
    updateCount();
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
          style: defaultTextStyle.copyWith(fontSize: 20),
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

  void updateCount() async {
    if (countTextBoxComponent != null && contains(countTextBoxComponent!)) {
      remove(countTextBoxComponent!);
      countTextBoxComponent = null;
    }
    final animals = [
      ChestAnimals.goat,
      ChestAnimals.chick,
      ChestAnimals.horse,
      ChestAnimals.duck,
      ChestAnimals.monkey,
      ChestAnimals.chicken,
      ChestAnimals.rabbit,
      ChestAnimals.moose,
      ChestAnimals.frog,
      ChestAnimals.owl,
      ChestAnimals.snake,
      ChestAnimals.gorilla,
      ChestAnimals.parrot,
      ChestAnimals.buffalo,
      ChestAnimals.walrus,
    ];

    final prefs = await SharedPreferences.getInstance();

    final count = animals.where((animals) => prefs.getBool(animals.name) ?? false).length;
    countTextBoxComponent = TextComponent(
      text: '$count/${animals.length}',
      textRenderer: TextPaint(
        style: defaultTextStyle.copyWith(fontSize: 20),
      ),
      position: Vector2(10, 10),
    );
    add(countTextBoxComponent!);
  }
}
