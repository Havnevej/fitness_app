import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home()
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HAH! Fitness',
          style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.blueGrey,
            fontFamily: 'Yanone',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
            color: Colors.black12,
            child: Image(
              width:25,
              height:25,
              image: AssetImage("assets/images/runner262x263.png"),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
            color: Colors.black12,
            onPressed: somefunction,
            child: Text("Something"),
            ),
        ],
      ),
    );
  }
  void somefunction() {
    print("hello its me, the button");
  }
}
