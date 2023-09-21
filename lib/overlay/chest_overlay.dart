import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:smittie/smittie_game.dart';

import '../components/objects/chest_animals.dart';
import '../core/text_style.dart';
import '../strings.dart';

class ChestOverlay extends StatelessWidget {
  const ChestOverlay(this.chestId, this.animal, this.game, {this.isOpened = false, super.key});

  final String chestId;
  final ChestAnimals animal;
  final SmittieGame game;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    final dialogSize = MediaQuery.sizeOf(context).shortestSide * 0.92;
    final imageSize = dialogSize * 0.3;
    final textSize = defaultTextStyle.copyWith(fontSize: dialogSize * 0.05);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: dialogSize,
              height: dialogSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: SpriteWidget.asset(
                      path: 'wooden-gui-32x32.png',
                      srcPosition: Vector2(14 * 32, 20 * 32),
                      srcSize: Vector2.all(3 * 32),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(dialogSize * 0.15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isOpened
                            ? Text(
                                strings.alreadyOpenedChest,
                                style: textSize,
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                animal.rhyme ?? '',
                                style: textSize,
                                textAlign: TextAlign.center,
                              ),
                        Image.asset(animal.asset, height: imageSize, width: imageSize),
                        SpriteButton.asset(
                          path: 'wooden-gui-32x32.png',
                          pressedPath: 'wooden-gui-32x32.png',
                          onPressed: () => game.closeMenu(chestId),
                          srcSize: Vector2(3 * 32, 32),
                          srcPosition: Vector2(13 * 32, 33 * 32),
                          label: Text(strings.close, style: textSize),
                          height: dialogSize * 0.12,
                          width: dialogSize * 0.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
