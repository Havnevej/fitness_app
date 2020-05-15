import 'dart:io';

import'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'dart:math';

import 'connection_handler.dart';
import 'friends.dart';
import 'leaderboard.dart';
import 'login.dart';
import 'my_profile.dart';
import 'loading.dart';
import 'my_profile_page.dart';
import 'challenges.dart';

class Home extends StatefulWidget {
  final Person user;
  final Connection connection;

  const Home({Key key, this.user, this.connection}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Person user;
  Connection connection;
  bool loading = false;
  int level = 1;
  int xpRequired = 1; //level*
  int xpCurrent = 0;
  int xpProgress = 0;
  @override
  void initState() {
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

          FlatButton.icon(
            padding: EdgeInsets.only(right: 100),
            icon: Icon(Icons.more_vert, color: Colors.greenAccent),
            label: Text('', style: TextStyle( color: Colors.greenAccent),),
            onPressed: () { _showbuttons();
            },
          ),

          Text('Fit2Gether',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
          FlatButton.icon(
            padding: EdgeInsets.only(left: 55),
            icon: Icon(Icons.person, color: Colors.greenAccent),
            label: Text('Logout', style: TextStyle( color: Colors.greenAccent),),
            onPressed: () async{
              await connection.logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
            },
          ),
        ],
        ),
      ),
      body: ListView(
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderBoard(user: user)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Challenges(user: user)),);
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
                          setState(()=> loading = true);
                          await connection.getMyUserData();
                          setState(() {
                            setState(() => loading = false);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => myProfilePage(user: user)));
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
                  setState(() {
                    xpRequired = level*1000;
                  });

                  if(xpCurrent == xpRequired){
                    setState(() {
                      xpCurrent=0;
                      level++;
                    });
                  }
                  if(xpCurrent != xpRequired){
                    setState(() {
                      xpCurrent+=200;
                    });
                  }
                  setState(() => xpProgress = (((xpCurrent*100)~/xpRequired)));
                  print(level);
                  print(xpCurrent);
                  print(xpRequired);
                  print(xpProgress);
                },
              ),
              CircularPercentIndicator(
                animateFromLastPercent: true,
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: ((xpProgress.toDouble())/100), //0.1
                center: new Text('LVL ${user.level}',
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

  void _showbuttons() => showDialog(context: context, builder: (context) => Theme(


    // flutter defined function
      data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
      // return object of type Dialog
      child: AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 200, 420),
        elevation: 0,
        //AlertDialog
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        content: Container(
          padding: EdgeInsets.fromLTRB(0, 0,0, 0),
          color: Colors.greenAccent,
          width: 200,
          height: 400,
          child: ListView(
            children: <Widget>[
              FlatButton.icon(
                label: Text("Friends"),
                icon: Icon(Icons.person,color: Colors.blueGrey[900],),
                onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => Friends(user:user, connection: connection,)));},

              ),
              Divider(height:0 ,color: Colors.blueGrey[900],),
              FlatButton.icon(
                label: Text("Amazing"),
                icon: Icon(Icons.settings,color: Colors.blueGrey[900],),
                onPressed:() {},
              ),
              Divider(height:0 ,color: Colors.blueGrey[900],),
            ],
          ),
        ),
      ),
    ),
  );
}


