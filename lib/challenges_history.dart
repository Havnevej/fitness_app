import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'connection_handler.dart';
import 'loading.dart';

class Challenges_history extends StatefulWidget {
  final Person user;
  final Connection connection;

  const Challenges_history({Key key, this.user, this.connection}) : super(key: key);

  @override
  _Challenges_history_state createState() => _Challenges_history_state();
}

class _Challenges_history_state extends State<Challenges_history> {
  List firstList = [];
  Person user;
  Connection connection;
  List challenges = [0];
  bool loading = false;

  @override
  void initState() {
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    super.initState();
    load_challenges_completed();
  }

  void load_challenges_completed() async{
    List temp = await connection.getChallenges();
    setState(() {
      challenges = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Challenges history',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            height: 80,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.blueGrey[700],
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Overall challenges completed: ${user.challengesCompleted}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold))),
                CircularPercentIndicator(
                  animateFromLastPercent: true,
                  radius: 40.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 3.0,
                  percent: 0.2, //0.1
                  center: new Text('${user.level}',
                    style:
                    GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.yellow, fontSize: 15,)),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.white,
                  progressColor: Colors.yellow,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                //////////////////////////////////////////////////////////////////FIRST CHALLENGE/////////////////////////////////////////////////////////////////////////////////////////
                ExpansionTile(
                  title: Text("Lower body challenges completed:", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color: Colors.green[400],
                                  shape: BoxShape.rectangle,
                                ),
                                height:50,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 17),
                                        child: Center(child: Text('${challenges[0]["title"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                //////////////////////////////////////////////////////////////////SECOND CHALLENGE/////////////////////////////////////////////////////////////////////////////////////////
                ExpansionTile(
                  title: Text("Upper body challenges completed:", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color: Colors.red[400],
                                  shape: BoxShape.rectangle,
                                ),
                                height:50,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 17),
                                        child: Center(child: Text('${challenges[1]["title"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                //////////////////////////////////////////////////////////////////THIRD CHALLENGE/////////////////////////////////////////////////////////////////////////////////////////
                ExpansionTile(
                  title: Text("Flexibility challenges completed:", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color: Colors.orangeAccent[400],
                                  shape: BoxShape.rectangle,
                                ),
                                height:50,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 17),
                                        child: Center(child: Text('${challenges[1]["title"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                //////////////////////////////////////////////////////////////////FOURTH CHALLENGE/////////////////////////////////////////////////////////////////////////////////////////
                ExpansionTile(
                  title: Text("Cardio challenges completed:", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color: Colors.lightBlue[400],
                                  shape: BoxShape.rectangle,
                                ),
                                height:50,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 17),
                                        child: Center(child: Text('${challenges[0]["title"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}