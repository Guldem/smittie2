import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smittie/components/interactabled_object.dart';
import 'package:smittie/smittie_game.dart';

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
  void interact(SmittieGame game) {
    animation = openAnimation;
    animationTicker?.onComplete = () async {
      final prefs = await SharedPreferences.getInstance();
      final isOpened = prefs.getBool(name);
      if (isOpened == null || !isOpened) {
        prefs.setBool(name, true);
        game.overlays.add(name);
      } else {
        game.overlays.add('$name-opened');
      }
    };
  }

  @override
  bool get interactable => animation != openAnimation;

  String get action => 'Open kistje';
}

enum ChestAnimals {
  bear('assets/images/animal_stickers/bear.png'),
  chicken('assets/images/animal_stickers/chicken.png'),
  cow('assets/images/animal_stickers/cow.png'),
  dog('assets/images/animal_stickers/dog.png'),
  duck('assets/images/animal_stickers/duck.png'),
  elephant('assets/images/animal_stickers/elephant.png'),
  giraffe('assets/images/animal_stickers/giraffe.png'),
  goat('assets/images/animal_stickers/goat.png'),
  monkey('assets/images/animal_stickers/monkey.png'),
  owl('assets/images/animal_stickers/owl.png'),
  pig('assets/images/animal_stickers/pig.png');

  const ChestAnimals(this.asset);

  final String asset;
}
