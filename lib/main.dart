import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smittie/smittie_game.dart';

import 'components/objects/chest_animals.dart';
import 'overlay/chest_overlay.dart';
import 'overlay/welcome_overlay.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MaterialApp(home: Scaffold(body: MyGame())));
}

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  @override
  void initState() {
    super.initState();
    Flame.device.fullScreen();
    Flame.device.setLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget<SmittieGame>(
      game: SmittieGame(),
      initialActiveOverlays: const ['welcome'],
      // initialActiveOverlays: const ['snake'],
      overlayBuilderMap: {
        'welcome': (context, game) => WelcomeOverLay(
              onPressed: () => game.overlays.remove('welcome'),
            ),
        for (var e in ChestAnimals.values) e.name: (context, game) => ChestOverlay(e.name, e, game),
        for (var e in ChestAnimals.values) ...{
          '${e.name}-opened': (context, game) => ChestOverlay('${e.name}-opened', e, game, isOpened: true),
        }
      },
    );
  }
}
