import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/register_second.dart';
import 'connection_handler.dart';
import 'constants.dart';
import 'loading.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';


class myProfilePage extends StatefulWidget {

  final Person user;
  final Person p;
  final Connection connection;
  const myProfilePage({Key key, this.p, this.connection, this.user}) : super(key: key);


  @override
  _myProfileState createState() => _myProfileState();
}

class _myProfileState extends State<myProfilePage> {
  Person user;
  @override
  bool loading = false;
  Person p;
  /*void initState() {
    p = widget.p;
    super.initState();*/
  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: (1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('My profile', style: TextStyle(color: Colors.greenAccent),),
            SizedBox(),
            FlatButton.icon(
              icon: Icon(
                Icons.people, color: Colors.greenAccent,),
              label: Text(
                '', style: TextStyle(color: Colors.greenAccent),),
              onPressed: () {
               //Navigator.of(context).pushReplacement(MaterialPageRoute(
                 //builder: (BuildContext context) => Friends()));
              },
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.exit_to_app, color: Colors.greenAccent,),
              label: Text(
                'Log out', style: TextStyle(color: Colors.greenAccent),),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Login()));
              },
            ),
          ],
        ),
      ),

      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Alibackground.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 20),
                color: Colors.blueGrey[800],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(child: Text("Hussein Miari", style: TextStyle(color: Colors.greenAccent, fontSize: 20),)),
                  ],
                ),
              ),
              Divider(height: 0, color: Colors.blueGrey[900], thickness: 2,),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blueGrey[800],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(child: Text("Level: 30", style: TextStyle(color: Colors.greenAccent, fontSize: 15, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              Divider(height: 0, color: Colors.blueGrey[900], thickness: 2,),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blueGrey[800],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Weight: 89 kg", style: TextStyle(color: Colors.greenAccent),),
                    //Text("Weight: ${p.weight} kg", style: TextStyle(color: Colors.greenAccent),),
                    Text("Height: 190 cm", style: TextStyle(color: Colors.greenAccent),),
                    //Text("Height: ${p.height} cm", style: TextStyle(color: Colors.greenAccent),),
                    Text("BMI: 25,4 ", style: TextStyle(color: Colors.greenAccent),),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //color: Colors.blueGrey[800],
                    padding: EdgeInsets.only(top: 5),
                    child: Text('Weight progression', style: TextStyle(color: Colors.greenAccent, fontSize: 15, /*fontWeight: FontWeight.bold*/),),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Sparkline(data: <double>[0, 1, 1.5, 2, 2.5, 2, 3.5, 1.5,1, 2.5, 2, 4],
                    sharpCorners: true,
                    lineWidth: 2,
                    lineColor: Colors.greenAccent,
                    fillMode: FillMode.below,
                    fillGradient: new LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blueGrey[700], Colors.blueGrey[800]]
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 150.0, // (background container size) - (circle height / 2)
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Donald.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }

}
