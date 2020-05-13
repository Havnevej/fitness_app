import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/utils/functions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'friends.dart';
import 'loading.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'connection_handler.dart';


class myProfilePage extends StatefulWidget {

  final Person user;
  final Connection connection;
  const myProfilePage({Key key, this.user, this.connection}) : super(key: key);

  @override
  _myProfileState createState() => _myProfileState();
}

class _myProfileState extends State<myProfilePage> {
  Person user;
  Connection connection;
  int level = 1;
  int xpRequired = 1; //level*
  int xpCurrent = 1500;
  int xpProgress = 1500;
  @override
  bool loading = false;
  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Color.fromRGBO(90, 125, 124, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(90, 125, 124, 1),
        elevation: (1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('My profile', style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1)),),
            SizedBox(),
            FlatButton.icon(
              icon: Icon(
                Icons.people, color: Color.fromRGBO(236, 203, 217, 1),),
              label: Text(
                '', style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1)),),
              onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Friends(user: user, connection: connection,)));
              },
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.exit_to_app, color: Color.fromRGBO(236, 203, 217, 1),),
              label: Text(
                'Log out', style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1)),),
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
                color: Color.fromRGBO(86, 85, 84, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text("${user.firstName} ${user.lastName}", style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1), fontSize: 20),)),
                    SizedBox(width: 15),
                    CircularPercentIndicator(
                      animateFromLastPercent: true,
                      radius: 50.0,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 5.0,
                      percent: 0.2, //0.1
                      center: new Text('$level',
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Color.fromRGBO(236, 203, 217, 1)),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.white,
                      progressColor: Color.fromRGBO(236, 203, 217, 1),
                    ),
                  ],
                ),
              ),
              Divider(height: 0, color: Color.fromRGBO(201, 202, 217, 1), thickness: 2,),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Color.fromRGBO(86, 85, 84, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Weight: ${user.weight} kg", style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1)),),
                    Text("Height: ${user.height} cm", style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1)),),
                    Text("BMI: ${calculateBMI(user.weight, user.height)}", style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1)),),
                  ],
                ),
              ),
              Divider(height: 0, color: Color.fromRGBO(201, 202, 217, 1), thickness: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text('Weight progression', style: TextStyle(color: Color.fromRGBO(236, 203, 217, 1), fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Sparkline(data: <double>[0, 1, 1.5, 2, 2.5, 2, 3.5, 1.5,1, 2.5, 2, 4],
                    sharpCorners: true,
                    lineWidth: 2,
                    lineColor: Color.fromRGBO(225, 239, 210, 1),
                    fillMode: FillMode.below,
                    fillColor: Color.fromRGBO(128, 255, 232,1 ),
                    fillGradient: new LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromRGBO(86, 85, 84, 1), Color.fromRGBO(86, 85, 84, 1),]
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
