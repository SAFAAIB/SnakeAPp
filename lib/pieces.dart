import 'package:flutter/material.dart';

class Piece extends StatefulWidget {
  final int posX , posY , size;
  final Color color;
  final bool isAnimated;

  Piece({this.posX, this.posY, this.size, this.color, this.isAnimated = false});

  @override
  _PieceState createState() => _PieceState();
}

class _PieceState extends State<Piece> with SingleTickerProviderStateMixin{
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        lowerBound: 0.25,
        upperBound: 1,
        duration: Duration(milliseconds: 1000),
        vsync: this);

    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed)
        animationController.reset();
      else if (status == AnimationStatus.dismissed)
        animationController.forward();
    });
    animationController.forward();

  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left : widget.posX.toDouble(),
      top:  widget.posY.toDouble(),
      child: Opacity(
        opacity: widget.isAnimated? animationController.value : 1,
        child: Container(
          height: widget.size.toDouble(),
          width: widget.size.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2 , color: Colors.white)
          ),
        ),
      ),

    );
  }
}
