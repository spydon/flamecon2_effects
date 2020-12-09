import 'package:flame/anchor.dart';
import 'package:flame/assets/images.dart';
import 'package:flame/components/sprite_component.dart';
import 'package:flame/effects/combined_effect.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/extensions/offset.dart';

class MyGame extends BaseGame with TapDetector {
  SpriteComponent flame;

  MyGame(Vector2 screenSize) {
    size = screenSize;
  }

  @override
  void onTapUp(TapUpDetails details) {
    final position = details.localPosition.toVector2();

    final scale = ScaleEffect(
      size: flame.size + Vector2(300, 300),
      duration: 3.0,
      curve: Curves.easeInExpo,
    );

    final move = MoveEffect(
      path: [position],
      duration: 2.0,
    );

    final rotate = RotateEffect(
      angle: position.x % 5,
      duration: 4.0,
      curve: Curves.bounceInOut,
    );

    flame.addEffect(
      CombinedEffect(
        effects: [scale, move, rotate],
        isAlternating: true,
        isInfinite: true
      )
    );
  }

  @override
  Future<void> onLoad() async {
    final image = await Images().load('flame.png');
    flame = SpriteComponent.fromImage(Vector2.all(250), image);
    flame.anchor = Anchor.center;
    flame.position.setFrom(size/2);
    add(flame);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Vector2 size = await Flame.util.initialDimensions();
  runApp(MyGame(size).widget);
}

