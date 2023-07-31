import 'package:flutter/material.dart';
import 'package:smittie/smittie_game.dart';

class ChestOverlay extends StatelessWidget {
  const ChestOverlay(this.chestId, this.path, this.game, {super.key});

  final String chestId;
  final String path;
  final SmittieGame game;

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
              const Text('Good job! You have found a chest!'),
              Image.asset(path),
              Text('This chest belongs to the present with the $chestId. Go ahead and open it :D'),
              ElevatedButton(
                onPressed: () => game.closeMenu(chestId),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
