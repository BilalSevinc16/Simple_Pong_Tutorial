import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double x;
  final double y;
  final double brickWidth; // out of 2
  final bool thisIsEnemy;

  const MyBrick({
    Key? key,
    required this.x,
    required this.y,
    required this.brickWidth,
    required this.thisIsEnemy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * x + brickWidth) / (2 - brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color:
              thisIsEnemy ? Colors.deepPurple.shade300 : Colors.pink.shade300,
          height: 20,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}
