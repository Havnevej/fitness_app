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
  int counter = 0;
  List notifications = [];

  @override
  void initState() {
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    for(int i = 0; i<15; i++){
      setState(() {
        notifications.add(i.toString());
      });

    }
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.greenAccent,), onPressed: () {
                  setState(() {
                  counter = 0;
                  _showN();
                });
              },),
              counter != 0 ? Positioned(
              right: 11,
              top: 11,
              child: Container(
                padding:  EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints:  BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text("$counter",style: TextStyle(color: Colors.white, fontSize: 8,),
                  textAlign: TextAlign.center,
                ),
              ),
            ) : Container(),
            ],
          ),
        ],
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderBoard(user: user, connection: connection)));
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
                        label: Text(user.firstName),
                        textColor: Colors.blueGrey[800],
                        onPressed: () {
                          _showbuttons();
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
                    counter++;
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
      data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(),//EdgeInsets.fromLTRB(200, 80, 0, 340),
        elevation: 0,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        content: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          color: Colors.greenAccent,
          width: 200,
          height: 190,
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
              FlatButton.icon(
                icon: Icon(Icons.person_outline, color: Colors.blueGrey[800]),
                label: Text('My profile'),
                textColor: Colors.blueGrey[800],
                onPressed: () async{
                  await connection.getMyUserData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => myProfilePage(user: user)));
                },
              ),
              Divider(height:0 ,color: Colors.blueGrey[900],),
              FlatButton.icon(
                icon: Icon(Icons.exit_to_app, color: Colors.blueGrey[900]),
                label: Text('Logout', style: TextStyle( color: Colors.blueGrey[900]),),
                onPressed: () async{
                  await connection.logout();
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
                },
              ),
              Divider(height:0 ,color: Colors.blueGrey[900],),
            ],
          ),
        ),
      ),
    ),
  );
  void _showN () => showDialog(context: context, builder: (context) =>
    Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(85, 0, 30, 0),
                  //color: Colors.greenAccent,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.teal[300],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      topLeft: Radius.circular(3),
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(3),
                    ),),
                  child:
                  ListView(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: notifications.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),),
                                            child:Text(notifications[index],),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                          ),],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(85, 0, 30, 0),
                  color: Colors.blueGrey[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.close, color: Colors.white,),
                      ),
                      Expanded(
                        child: Container(
                          child: FlatButton(
                            child: Text("Close",style: TextStyle(color: Colors.white),),
                            onPressed: (){},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),],
      ),
    ),
  );
}


