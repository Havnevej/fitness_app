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
  final Connection connection;

  const Home(this.connection);

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
  double xpProgress = 0;
  int notificationCounter = 0;
  int counterAcceptReq = 0;
  List notificationsAcceptedReq = [];
  List<dynamic> challenges = [];
  List<Color> colors = [];
  SharedPreferences prefs;

  @override
  void initState() {
    connection = widget.connection;
    user = connection.loggedInPerson;
    colors = [Colors.blue,Colors.green,Colors.purple,Colors.orange];
    super.initState();
    streamChallenges();
    restoreSharedPrefs();
    xpCurrent = user.exp;
  }

  restoreSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    notificationsAcceptedReq = [];
    var friendsList = user.friendslist;
    var savedOut = [];

    savedOut.add(await prefs.getString('${user.email}notifications'));
    for (var i = 0; i<savedOut.length; i++){
      if(friendsList.contains(savedOut[i])){
        await notificationsAcceptedReq.add(savedOut[i]);
      }
    }
    setState(() {
      notificationCounter = user.friendRequestsIncoming.length + notificationsAcceptedReq.length;
    });
  }

  streamChallenges()async*{
    challenges = await connection.getChallenges();
  }

  @override
  Widget build(BuildContext context) {

    if(xpCurrent>=user.level*1000){xpCurrent = 0;user.level++;}


    xpProgress = (xpCurrent / (user.level*1000) * 100);

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        title: Text('Fit2Gether',
          style: GoogleFonts.lato(
            fontSize: 32,
            letterSpacing: 5.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.only(top: 10),
                icon: Icon(Icons.notifications, color: Colors.white,),
                onPressed: () {
                  setState(() {
                    //restore();
                    notificationCounter = 0;
                    _showNotification(user.friendRequestsIncoming,notificationsAcceptedReq);
                });
              },),
              notificationCounter != 0 ? Positioned(
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
                child: Text('$notificationCounter',style: TextStyle(color: Colors.white, fontSize: 8,),
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
                          colors: [Colors.blueGrey[800], Colors.blueGrey[900]],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.list, size:20 ,color: Colors.lightGreenAccent, ), //size parameter added to fix overflowing pixels.
                        label: Text('Leaderboard'),
                        textColor: Colors.white,
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
                          colors: [Colors.blueGrey[800], Colors.blueGrey[900]],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.people, color: Colors.lightGreenAccent),
                        label: Text('Friends'),
                        textColor: Colors.white,
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
                          colors: [Colors.blueGrey[800], Colors.blueGrey[900]],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                        ),
                      ),
                      child: FlatButton.icon(
                        icon: Icon(Icons.person_outline, color: Colors.lightGreenAccent),
                        label: Text(user.firstName),
                        textColor: Colors.white,
                        onPressed: () {
                          _showbuttons();
                          },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 0, color: Colors.lightGreenAccent,),
              SizedBox(height: 47,),
              CircularPercentIndicator(
                animateFromLastPercent: true,
                radius: 200.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: (xpProgress.toDouble()/100) <= 1 ? (xpProgress.toDouble()/100) : 0 ,
                center: Text('LVL ${user.level}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blueGrey,
                progressColor: Colors.lightGreen,//lightGreenAccent
              ),
              SizedBox(height: 40,),
              Container(
                color: Colors.blueGrey[600],
                height:20,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 70,
                      child: Center(child: Text('Title'),),
                    ),
                    VerticalDivider(width:0,color: Colors.black,),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: Center(child: Text('Description')),
                      ),
                    ),
                    VerticalDivider(width:0,color: Colors.black,),
                    Container(
                      width: 50,
                      child: Center(child: Text('Reward')),
                    ),
                  ],
                ),
              ),
              Divider(height: 0, color: Colors.lightGreenAccent, thickness: 1,),
            ],
          ),
          StreamBuilder(
              stream: streamChallenges(),
              builder: (context, AsyncSnapshot snapshot) {
                return Container(
                  color: Colors.blueGrey[800],
                  height: 232,
                  child: challenges?.isEmpty ?? true ?
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.refresh),
                            tooltip: 'refresh',
                            onPressed: (){
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 55,),
                      Container(
                        child: Text('NO CHALLENGES LEFT FOR THE DAY!', style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: challenges.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            color: Colors.red,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blueGrey[400], Colors.blueGrey[700]],
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                ),
                              ),
                              height: 58,
                              //color: colors[index],
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 5 ),
                                    width: 70,
                                    child: Column(
                                      children: <Widget>[
                                        Text('${challenges[index]["title"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(width:0,color: Colors.black,),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text('${challenges[index]["desc"]}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 14)), textAlign: TextAlign.center,),
                                          ]
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(width:0,color: Colors.black,),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(7, 5, 0, 0),
                                    width: 50,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('${challenges[index]["point_reward"]} Points', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 14)))]),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: (){
                              setState(() {
                                //colors.removeAt(index); // moved TO yes no choice
                                challengeComplete(challenges,index);
                                //challenges.removeAt(index);
                                //xpCurrent += challenges[index]['point_reward'];
                                //connection.completeChallenge(jsonEncode(challenges[index]));
                              });
                            },
                          ),
                          Divider(height: 1, color: Colors.lightGreenAccent, thickness: 1,),
                        ],
                      );
                  }),
                );},
          ),
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
          color: Colors.blueGrey[900],
          width: 200,
          height: 145,
          child: ListView(
            children: <Widget>[
              FlatButton.icon(
                label: Text('Challenges history', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                icon: Icon(Icons.fitness_center,color: Colors.lightGreenAccent,),
                onPressed:(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Challenges_history(user:user, connection: connection, xpProgress: xpProgress)));},
              ),
              Divider(height:0 ,color: Colors.lightGreenAccent,),
              FlatButton.icon(
                icon: Icon(Icons.person_outline, color: Colors.lightGreenAccent),
                label: Text('My profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                onPressed: () async{
                  await connection.getMyUserData();
                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => myProfilePage(connection: connection, user: user, xpProgress: xpProgress))); // currentxp
                },
              ),
              Divider(height:0 ,color: Colors.lightGreenAccent,),
              FlatButton.icon(
                icon: Icon(Icons.exit_to_app, color: Colors.lightGreenAccent),
                label: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                onPressed: () async{
                  //final SharedPreferences prefs = await SharedPreferences.getInstance();
                  //prefs.clear();
                  await connection.logout();
                  Navigator.pop(context);
                  await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _showNotification (List<dynamic> friendsInc, List<dynamic> notificationsAcceptedReq) => showDialog(context: context, builder: (context) =>
    StatefulBuilder(
      builder: (context, setState) {
        return Material(
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
                        color: Colors.blueGrey[800],
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
                                SizedBox(height: 7,),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      width: 130,
                                      height: 25,
                                      child: Center(child: Text('Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 87),
                                      height: 25,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.blueGrey[700], Colors.blueGrey[800]],
                                          begin: FractionalOffset.bottomCenter,
                                          end: FractionalOffset.topCenter,
                                        ),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50.0),
                                          topLeft: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0),
                                          topRight: Radius.circular(50.0),),
                                      ),
                                      child: FlatButton(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text('clear', style: TextStyle(color: Colors.white),),
                                        onPressed: () {
                                          setState(() {
                                            friendsInc.removeRange(0, friendsInc.length);
                                            notificationsAcceptedReq.removeRange(0, notificationsAcceptedReq.length);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.white,height: 15,),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: friendsInc.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        children: [
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
                                              child:
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(fontSize: 14, color: Colors.black),
                                                          children: <TextSpan>[
                                                            TextSpan(text:'${friendsInc[index]} ', style: TextStyle(fontWeight: FontWeight.bold)),
                                                            TextSpan(text: ('sent you a friend request.')),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                }),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: notificationsAcceptedReq.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        children: [
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
                                              child: Container(
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(fontSize: 14, color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(text:'${notificationsAcceptedReq[index]} ', style: TextStyle(fontWeight: FontWeight.bold)),
                                                      TextSpan(text: ('accepted your friend request.')),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                            ],),
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
                                child: Text('Close',style: TextStyle(color: Colors.white),),
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
        );}
    ),);


  void challengeComplete (List<dynamic> challenges, int index) => showDialog(context: context, builder: (context) =>
    Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(50, 450, 50, 0),
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            color: Colors.blueGrey[100],
            height: 125,
            width: 250,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      height: 40,
                      width: 220,
                      child: Column(
                          children: [
                            Center(child: Text('DID YOU COMPLETE THE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
                            ),
                            Center(child: Text('CHALLENGE?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                      ]),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(height: 0,color: Colors.black,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.blueGrey[800],
                          child: Text('Yes!',style: TextStyle(color: Colors.white),),
                          onPressed: () async{
                            await connection.completeChallenge(jsonEncode(challenges[index]));
                            setState(() {
                              xpCurrent += challenges[index]['point_reward'];
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.blueGrey[800],
                          child: Text('Cancel',style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}




