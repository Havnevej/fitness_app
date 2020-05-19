import 'dart:convert';

import'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'connection_handler.dart';
import 'friends.dart';
import 'leaderboard.dart';
import 'login.dart';
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
  List firstList =  [];
  List secondList = [];
  Person user;
  Connection connection;
  List challenges = [0];
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
    load_challenges();
  }

  void load_challenges() async{
    List temp = await connection.getChallenges();
    setState(() {
      challenges = temp;
      /*firstList.add(challenges[0]);
      firstList.add(challenges[1]);
      secondList.add(challenges[2]);
      secondList.add(challenges[3]);*/
    });
  }

  @override
  Widget build(BuildContext context) {
    print(firstList);
    //print(secondList);
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

          FlatButton.icon(
            padding: EdgeInsets.only(right: 100),
            icon: Icon(Icons.more_vert, color: Colors.white),
            label: Text('', style: TextStyle( color: Colors.white),),
            onPressed: () { _showbuttons();
            },
          ),

          Text('Fit2Gether',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
                          colors: [Colors.blueGrey, Colors.blueGrey],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.list, size:20 ,color: Colors.yellow, ), //size parameter added to fix overflowing pixels.
                        label: Text('Leaderboard'),
                        textColor: Colors.yellow,
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
                          colors: [Colors.blueGrey, Colors.blueGrey],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.fitness_center, color: Colors.yellow),
                        label: Text('Challenges'),
                        textColor: Colors.yellow,
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
                          colors: [Colors.blueGrey, Colors.blueGrey],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.person_outline, color: Colors.yellow),
                        label: Text(user.firstName),
                        textColor: Colors.yellow,
                        onPressed: () {
                          _showbuttons();
                          },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              /*IconButton(
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
              ),*/
              CircularPercentIndicator(
                animateFromLastPercent: true,
                radius: 200.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: ((xpProgress.toDouble())/100), //0.1
                center: new Text('LVL ${user.level}',
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blueGrey,
                progressColor: Colors.greenAccent,
              ),
              SizedBox(height: 50),
            ],
          ),
          FutureBuilder<List<dynamic>>(
              future: connection.getChallenges(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7,
                      ),
                      height: 120,
                      width: 205.5,
                      decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle),
                  );
                } else {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: firstList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FlatButton(
                                    onPressed: (){
                                      setState(() {
                                        firstList.removeAt(index);
                                        xpProgress = firstList[index]['points'];
                                        connection.completeChallenge(jsonEncode(challenges[index]));
                                      });
                                    },
                                    child: Container(
                                      child: Container(padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                      ),
                                        height: 120,
                                        width: 205.5,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.rectangle),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(child: Text('Challenge: ${challenges[index]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                            Center(child: Text('${challenges[index]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                            Center(child: Text('Difficulty: ${challenges[index]["difficult"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                            Center(child: Text('Reward: ${challenges[index]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                          ],
                                        ),

                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: secondList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FlatButton(
                                    onPressed: (){
                                      setState(() {
                                        secondList.removeAt(index);
                                        xpProgress = secondList[index]['points'];
                                        connection.completeChallenge(jsonEncode(challenges[index]));
                                      });
                                    },
                                    child: Container(
                                      child: Container(padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                      ),
                                        height: 120,
                                        width: 205.5,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.rectangle),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Center(child: Text('Challenge: ${challenges[index]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                              Center(child: Text('${challenges[index]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                              Center(child: Text('Difficulty: ${challenges[index]["difficult"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                              Center(child: Text('Reward: ${challenges[index]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                            ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),

                  );
                }
              },
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //////////////////////////////////////////////////////////////////FIRST BOX////////////////////////////////////////////////////////////////////////////////////////
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                height: 120,
                width: 205.5,
                decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text('Challenge: ${challenges[0]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('${challenges[0]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Difficulty: ${challenges[0]["difficult"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Reward: ${challenges[0]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
              //////////////////////////////////////////////////////////////////SECOND BOX////////////////////////////////////////////////////////////////////////////////////////
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                height: 120,
                width: 205.5,
                decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text('Challenge: ${challenges[1]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('${challenges[1]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Difficulty: ${challenges[1]["difficult"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Reward: ${challenges[1]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //////////////////////////////////////////////////////////////////THIRD BOX////////////////////////////////////////////////////////////////////////////////////////
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                height: 120,
                width: 205.5,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text('Challenge: ${challenges[2]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('${challenges[2]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Difficulty: ${challenges[2]["difficult"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Reward: ${challenges[2]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
              //////////////////////////////////////////////////////////////////FOURTH BOX////////////////////////////////////////////////////////////////////////////////////////
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                height: 120,
                width: 205.5,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text('Challenge: ${challenges[3]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('${challenges[3]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Difficulty: ${challenges[3]["difficult"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                    Center(child: Text('Reward: ${challenges[3]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
            ],
          ),*/
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
}

/*
connection.completeChallenge(jsonEncode(challenges[0]));
xpCurrent*challenges[0]['points'];

 */


  /*Widget _dissmissAnimation(BuildContext context, int index){

  }*/



