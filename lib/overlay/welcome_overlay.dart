import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import '../core/text_style.dart';

class WelcomeOverLay extends StatelessWidget {
  const WelcomeOverLay({required this.onPressed, super.key});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/ai/stable-diffusion-xl-5-transformed.jpeg', fit: BoxFit.fitWidth),
        ),
        Positioned.fill(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 10 * 32,
                height: 10 * 32,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SpriteWidget.asset(
                        path: 'wooden-gui-32x32.png',
                        srcPosition: Vector2(14 * 32, 20 * 32),
                        srcSize: Vector2.all(3 * 32),
                      ),
                    ),
                    Positioned(
                      top: 2 * 32,
                      left: 2 * 32,
                      right: 2 * 32,
                      child: Column(
                        children: [
                          Text('De avonturen van Smittie 2', style: defaultTextStyle.copyWith(fontSize: 32), textAlign: TextAlign.center),
                          const SizedBox(height: 32),
                          Text('Weet jij alle dieren te vinden?', style: defaultTextStyle.copyWith(fontSize: 18), textAlign: TextAlign.center),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SpriteButton.asset(
                path: 'wooden-gui-32x32.png',
                pressedPath: 'wooden-gui-32x32.png',
                onPressed: onPressed,
                srcSize: Vector2(3 * 32, 32),
                srcPosition: Vector2(13 * 32, 33 * 32),
                label: Text('Start', style: defaultTextStyle),
                height: 48,
                width: 128,
              ),
            ],
          ),
        )
      ],
    );
  }
}
