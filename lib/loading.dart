import 'package:flutter/material.dart';
import 'dart:math';

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {

  AnimationController rotationController;

  @override
  void dispose() {
    this.rotationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    rotationController = AnimationController(vsync: this, duration: Duration(seconds: 8), upperBound: pi * 2);
    super.initState();
    rotationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ColorFiltered(
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                    child: Container(child : Image.asset('assets/images/håndvægt.png',width: 300,height: 100,)),
                    //Image(
                    //image: NetworkImage('https://i.dlpng.com/static/png/6908413_preview.png'),),
                  ),
                  colorFilter: ColorFilter.mode(Colors.greenAccent, BlendMode.color),
                ),

              ),
              /*RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                child: Container
                  (child : Transform(
                    alignment:  Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Image.asset('assets/images/håndvægt.png',width: 300,height: 100,)),
                ),
                //Image(
                //image: NetworkImage('https://i.dlpng.com/static/png/6908413_preview.png'),),
              ),*/

            ],
          ),
        ),
      );
  }
}
