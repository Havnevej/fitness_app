import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.greenAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
