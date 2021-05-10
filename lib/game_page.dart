import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_app/control_panel.dart';
import 'package:snake_app/pieces.dart';
import 'package:snake_app/utils/size_config.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

enum Direction { up, down, left, right }

class _GamePageState extends State<GamePage> {
  int upperX, upperY, lowerX, lowerY;
  int length = 5;
  Direction direction = Direction.right;
  double screenHeight, screenWidth;
  int step = 20;
  Offset foodPos;

  Piece food;
  double speed = 1;
  int score = 0;
  List<Offset> positions = [];
  Timer timer;

  changeSpeed() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: 150 ~/ speed), (timer) {
      setState(() {});
    });
  }

  Direction getRandomDirection(){
    int val = Random().nextInt(4);
    direction = Direction.values[val];
    return direction;
  }
  restart() {
    score = 0;
    positions = [];
    length = 5;
    speed = 1 ;
    direction = getRandomDirection();
    changeSpeed();
  }

  Widget getControl() {
    return ControlPanel(
      onTapped: (Direction newDir) {
        this.direction = newDir;
      },
    );
  }

  @override
  initState() {
    super.initState();
    restart();
  }

  showGameOverDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Color(0XFF810B44),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.pinkAccent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                'Game Over',
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'Your game is over but you played well, your score = $score',
                style: TextStyle(
                  color: Colors.white, fontSize: 20,),
              ),
              actions: [
                TextButton(onPressed: () async {
                  Navigator.pop(context);
                  restart();
                },
                  child: Text(
                  'Restart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,),),
                ),
              ],

          );
        });
  }

  int getTens(int num) {
    int output;
    output = (num ~/ step) * step;
    if (output == 0) output += step;
    return output;
  }

  Offset getPos() {
    Offset position;
    int x = Random().nextInt(upperX) + lowerX;
    int y = Random().nextInt(upperY) + lowerY;
    position = Offset(getTens(x).toDouble(), getTens(y).toDouble());
    return position;
  }

  getFood() async {
    if (foodPos == null) foodPos = getPos();

    if (foodPos == positions[0]) {
      length++;
      speed += .25;
      score += 5;
      foodPos =  getPos();
    }

    food = Piece(
      posX: foodPos.dx.toInt(),
      posY: foodPos.dy.toInt(),
      size: step,
      color: Color(0XFF810B44),
      isAnimated: true,
    );
  }

  Future<Offset> getNextPosition(Offset position) async{
    Offset nextPos;
    if (direction == Direction.right)
      nextPos = Offset(position.dx + step, position.dy);
    else if (direction == Direction.left)
      nextPos = Offset(position.dx - step, position.dy);
    else if (direction == Direction.up)
      nextPos = Offset(position.dx, position.dy - step);
    else if (direction == Direction.down)
      nextPos = Offset(position.dx, position.dy + step);

    if (detectCollision(position) == true) {
      if (timer!=null && timer.isActive)
        timer.cancel();
      await Future.delayed(
          Duration(milliseconds: 100), () => showGameOverDialog());
      return position;
    }

    return nextPos;
  }

  void draw() async {
    if (positions.isEmpty) {
      positions.add( getPos());
    }

    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }
    for (int i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
    }
    positions[0] = await getNextPosition(positions[0]);
  }

  Widget getScore() {
    return Positioned(
      right: 10,
      top: 70,
      child: Text(
        'Score = $score',
        style: TextStyle(fontSize: 28),
      ),
    );
  }

  List<Piece> getPieces() {
    List pieces = <Piece>[];
    draw();
    getFood();
    for (int i = 0; i < length; i++) {
      if (i >= positions.length) continue;
      pieces.add(
        Piece(
          posX: positions[i].dx.toInt(),
          posY: positions[i].dy.toInt(),
          size: step,
          color: i.isEven ? Color(0XFF810B44) : Color(0XFFEF2FA2),
        ),
      );
    }
    return pieces;
  }

  bool detectCollision(Offset position) {
    if (position.dx >= upperX && direction == Direction.right) return true;
    if (position.dx <= lowerX && direction == Direction.left) return true;
    if (position.dy >= upperY && direction == Direction.down) return true;
    if (position.dy <= lowerY && direction == Direction.up) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    lowerX = step;
    lowerY = step;
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    upperX = getTens(screenWidth.toInt() - step);
    upperY = screenHeight.toInt() - step;
    return Scaffold(
      backgroundColor: Color(0XFFFFDFDC),
      body: Stack(
        children: [
          Stack(
            children: getPieces(),
          ),
          getControl(),
          food,
          getScore(),

        ],
      ),
    );
  }
}
