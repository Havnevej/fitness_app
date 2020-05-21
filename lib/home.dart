import 'dart:convert';
import'package:flutter/material.dart';
import 'package:flutter_fitness_app/challenges_history.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connection_handler.dart';
import 'friends.dart';
import 'leaderboard.dart';
import 'login.dart';
import 'loading.dart';
import 'my_profile_page.dart';


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
  bool loading = false;
  int level = 1;
  int xpRequired = 1; //level*
  int xpCurrent = 0;
  double xpProgress = 0;
  int counter = 0;
  List notifications = [];
  List<dynamic> challenges = [];
  List<Color> colors = [Colors.blue[400],Colors.green,Colors.purple,Colors.orange];

  @override
  void initState() {
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    connection.getMyUserData();
    super.initState();
    restore();
  }
  restore() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //notifications = [(prefs.getString("notifications") ?? "NOO!!")];
      notifications =  prefs.getStringList("incomingR");
      counter = notifications.length;
    });
  }

  Color challengeColor(){
    Color returncolor = colors[0];
    colors.removeAt(0);
    return returncolor;
  }


  @override
  Widget build(BuildContext context) {
    colors = [Colors.blue[400],Colors.green,Colors.purple,Colors.orange];
    if(xpCurrent>=user.level*1000){xpCurrent = 0;}
    xpCurrent = user.exp;
    xpProgress = (xpCurrent / (user.level*1000) * 100);

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.blueGrey,), onPressed: () {
                  setState(() {
                    //restore();
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
                        icon: Icon(Icons.people, color: Colors.yellow),
                        label: Text('Friends'),
                        textColor: Colors.yellow,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Friends(user:user, connection: connection,)));
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
              CircularPercentIndicator(
                animateFromLastPercent: true,
                radius: 200.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: (xpProgress.toDouble()/100) <= 1 ? (xpProgress.toDouble()/100) : 0 , //0.1
                center: new Text('LVL ${user.level}',
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blueGrey,
                progressColor: Colors.yellow,
              ),
              SizedBox(height: 50),
            ],
          ),
          FutureBuilder<List<dynamic>>(
              future: connection.getChallenges(),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>>snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
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
                  List<dynamic> snap = snapshot.data;
                  print(snap.toString() + " 123");
                  List firstList =  [];
                  List secondList = [];
                  switch (snap.length){
                    case 0: {
                      return Text('No more challenges for today, come back tomorrow', style: TextStyle(color: Colors.red));
                    }
                      break;
                    case 1: {
                      firstList.add(snapshot.data[0]);
                    }
                    break;
                    case 2: {
                      firstList.add(snapshot.data[0]);
                      secondList.add(snapshot.data[1]);
                    }
                    break;
                    case 3: {
                      firstList.add(snapshot.data[0]);
                      firstList.add(snapshot.data[1]);
                      secondList.add(snapshot.data[2]);
                    }
                    break;
                    case 4: {
                      firstList.add(snapshot.data[0]);
                      firstList.add(snapshot.data[1]);
                      secondList.add(snapshot.data[2]);
                      secondList.add(snapshot.data[3]);
                    }
                    break;
                  }
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
                                        xpCurrent += firstList[index]['point_reward'];
                                        connection.completeChallenge(jsonEncode(firstList[index]));
                                        firstList.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                        height: 120,
                                        width: 205.5,
                                        decoration: BoxDecoration(
                                            color: challengeColor(),
                                            shape: BoxShape.rectangle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Center(child: Text('Challenge: ${firstList[index]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                              Center(child: Text('${firstList[index]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14)), textAlign: TextAlign.center,)),
                                              Center(child: Text('Reward: ${firstList[index]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14)))),
                                            ],
                                          ),
                                        ),
                                    ),
                                  );
                                },
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
                                        xpCurrent += secondList[index]['point_reward'];
                                        connection.completeChallenge(jsonEncode(secondList[index]));
                                        secondList.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                        height: 120,
                                        width: 205.5,
                                        decoration: BoxDecoration(
                                            color: challengeColor(),
                                            shape: BoxShape.rectangle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Center(child: Text('Challenge: ${secondList[index]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                                                Center(child: Text('${secondList[index]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14)), textAlign: TextAlign.center,)),
                                                Center(child: Text('Reward: ${secondList[index]["point_reward"]} points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 14)))),
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
          color: Colors.green,
          width: 200,
          height: 192.5,
          child: ListView(
            children: <Widget>[
              FlatButton.icon(
                label: Text("Challenges history"),
                icon: Icon(Icons.fitness_center,color: Colors.blueGrey[900],),
                onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => Challenges_history(user:user, connection: connection,)));},
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
                      //Container(child: Icon(Icons.close, color: Colors.white,),),
                      Expanded(
                        child: Container(
                          child: FlatButton(
                            child: Text("Close",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              Navigator.pop(context);
                            },
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


