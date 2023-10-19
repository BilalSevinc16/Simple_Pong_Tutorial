import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_pong_tutorial/ball.dart';
import 'package:simple_pong_tutorial/brick.dart';
import 'package:simple_pong_tutorial/coverscreen.dart';
import 'package:simple_pong_tutorial/scorescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { up, down, left, right }

class _HomePageState extends State<HomePage> {
  // player variables (bottom brick)
  double playerX = -0.2;
  double brickWidth = 0.4; // out of 2
  int playerScore = 0;

  // enemy variables (top brick)
  double enemyX = -0.2;
  int enemyScore = 0;

  // ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;

  // game settings
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      // update direction;
      updateDirection();
      //move ball
      moveBall();
      // move enemy
      moveEnemy();
      // check if player is dead
      if (isPlayerDead()) {
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }
      if (isEnemyDead()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
    });
  }

  bool isEnemyDead() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
    });
  }

  void _showDialog(bool enemyDied) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                enemyDied ? "PINK WIN" : "PURPLE WIN",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: enemyDied
                        ? Colors.pink.shade100
                        : Colors.deepPurple.shade100,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(
                        color: enemyDied
                            ? Colors.pink.shade800
                            : Colors.deepPurple.shade800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      // update vertical direction
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = Direction.up;
      } else if (ballY <= -0.9) {
        ballYDirection = Direction.down;
      }
      // update horizontal direction
      if (ballX >= 1) {
        ballXDirection = Direction.left;
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  void moveBall() {
    setState(() {
      // vertical movement
      if (ballYDirection == Direction.down) {
        ballY += 0.003;
      } else if (ballYDirection == Direction.up) {
        ballY -= 0.003;
      }
      // horizontal movement
      if (ballXDirection == Direction.left) {
        ballX -= 0.003;
      } else if (ballXDirection == Direction.right) {
        ballX += 0.003;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) {
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          }
        },
        child: GestureDetector(
          onTap: startGame,
          child: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: Center(
              child: Stack(
                children: [
                  // tap to play
                  CoverScreen(
                    gameHasStarted: gameHasStarted,
                  ),
                  // score screen
                  ScoreScreen(
                    gameHasStarted: gameHasStarted,
                    enemyScore: enemyScore,
                    playerScore: playerScore,
                  ),
                  // enemy (top brick)
                  MyBrick(
                    x: enemyX,
                    y: -0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: true,
                  ),
                  // player (bottom brick)
                  MyBrick(
                    x: playerX,
                    y: 0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: false,
                  ),
                  // ball
                  MyBall(
                    x: ballX,
                    y: ballY,
                    gameHasStarted: gameHasStarted,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
