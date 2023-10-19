import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool gameHasStarted;

  const CoverScreen({Key? key, required this.gameHasStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: Text(
        gameHasStarted ? "" : "T A P  T O  P L A Y",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
