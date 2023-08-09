import 'package:flutter/material.dart';
import 'package:smittie/smittie_game.dart';

import '../components/chests.dart';
import '../strings.dart';

class ChestOverlay extends StatelessWidget {
  const ChestOverlay(this.chestId, this.animal, this.game, {this.isOpened = false, super.key});

  final String chestId;
  final ChestAnimals animal;
  final SmittieGame game;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.brown.shade700,
              width: 2,
            ),
            color: Colors.brown.shade300,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isOpened ? Text(strings.alreadyOpenedChest) : Text(strings.successOpenChest(animal.name)),
              Image.asset(animal.asset),
              ElevatedButton(
                onPressed: () => game.closeMenu(chestId),
                child: Text(strings.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
