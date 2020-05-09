import 'dart:io';

import'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'dart:math';

import 'connection_handler.dart';
import 'login.dart';
import 'my_profile.dart';


class Home extends StatefulWidget {
  final Person user;
  final Connection connection;

  const Home({Key key, this.user, this.connection}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level = 1;
  int percentage = 0;
  Person user;
  Connection connection;
  @override
  void initState() {
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        title: Text('Fit2Gether',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.greenAccent),
            label: Text('Logout', style: TextStyle( color: Colors.greenAccent),),
            onPressed: () async{
              await connection.logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
            },
          )
        ],
      ),
      body: ListView( // changed from container to listview  ***** BrewList(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.greenAccent],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.list, size:20 ,color: Colors.blueGrey[800], ), //size parameter added to fix overflowing pixels.
                        label: Text('Leaderboard'),
                        textColor: Colors.blueGrey[800],
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderBoard()),);
                          },
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1, color: Colors.black, thickness: 1),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.greenAccent],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.fitness_center, color: Colors.blueGrey[900]),
                        label: Text('Challenges'),
                        textColor: Colors.blueGrey[800],
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Challenges()),);
                        },
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1, color: Colors.black, thickness: 1),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.greenAccent],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.person_outline, color: Colors.blueGrey[800]),
                        label: Text('My profile'),
                        textColor: Colors.blueGrey[800],
                        onPressed: () async{
                          await connection.getMyUserData();
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(user: user)));
                          });
                          },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),
              IconButton(
                tooltip: 'Add lvl',
                icon: Icon(Icons.add),
                onPressed: () {
                  if(percentage == 100){
                    setState(() {
                      percentage=0;
                      level++;
                    });
                  }
                  if(percentage != 100){
                    setState(() {
                      percentage+=10;
                      print(level);
                      print(percentage);
                    });
                  }
                },
              ),
              CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: ((percentage.toDouble())/100), //0.1
                center: new Text('LVL $level',
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.greenAccent),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blueGrey,
                progressColor: Colors.greenAccent,
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(25),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: 0.9,
                  backgroundColor: Colors.blueGrey,
                  center: Text("LEVEL 1"
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 10),


            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('LIFETIME POINTS', style: TextStyle(color: Colors.greenAccent),),
                    ),
                  ),],
              ),
              SizedBox(width: 50),
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('LIFETIME POINTS', style: TextStyle(color: Colors.greenAccent),),
                    ),
                  ),
                ],
              ),
            ],

          ),
          Divider(height: 1, color: Colors.greenAccent),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('LIFETIME POINTS', style: TextStyle(color: Colors.greenAccent),),
                    ),
                  ),],
              ),
              SizedBox(width: 50),
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text('LIFETIME POINTS', style: TextStyle(color: Colors.greenAccent),),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 1, color: Colors.greenAccent),
        ],
      ),
    );
  }
}
