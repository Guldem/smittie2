import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smittie/components/objects/interactabled_object.dart';
import 'package:smittie/smittie_game.dart';
import 'package:smittie/strings.dart';

class Chest extends InteractableObject with HasGameRef<SmittieGame> {
  Chest({required this.name, super.position, super.size});

  final String name;
  late final SpriteAnimation openAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    openAnimation = await gameRef.loadSpriteAnimation(
      'chest.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.15,
        loop: false,
      ),
    );
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
  void interact(SmittieGame game, void Function() onComplete) {
    animation = openAnimation;
    animationTicker?.onComplete = () async {
      final prefs = await SharedPreferences.getInstance();
      final isOpened = prefs.getBool(name);
      if (isOpened == null || !isOpened) {
        prefs.setBool(name, true);
        onComplete();
        game.overlays.add(name);
      } else {
        game.overlays.add('$name-opened');
      }
    };
  }

  @override
  bool get interactable => animation != openAnimation;

  String get action => strings.openChest;
}
