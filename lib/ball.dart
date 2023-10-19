import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double x;
  final double y;
  final bool gameHasStarted;

  const MyBall({
    Key? key,
    required this.x,
    required this.y,
    required this.gameHasStarted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(x, y),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              width: 14,
              height: 14,
            ),
          )
        : Container(
            alignment: Alignment(x, y),
            child: AvatarGlow(
              endRadius: 60,
              child: Material(
                elevation: 8,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  radius: 7,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          );
  }
}
