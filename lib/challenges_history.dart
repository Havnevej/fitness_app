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
  Person user;
  Connection connection;
  Map<dynamic, dynamic> _map;
  bool loading = false;
  int totalChallenges = 0;
  int cardioChallenges = 0;
  int flexibilityChallenges = 0;
  int upperBodyChallenges = 0;
  int lowerBodyChallenges = 0;

  @override
  void initState() {
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    super.initState();
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
          FutureBuilder<Map<dynamic, dynamic>>(
              future: connection.getCompletedChallenges(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Please wait its loading...'));
                } else {
                  print("${snapshot.data}");
                  _map = snapshot.data;
                  List<dynamic> challenges = _map.values.toList();
                  totalChallenges = challenges[0];
                  cardioChallenges = challenges[1];
                  flexibilityChallenges = challenges[2];
                  upperBodyChallenges = challenges[3];
                  lowerBodyChallenges = challenges[4];
                  return Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(0,10),
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Overall challenges completed: $totalChallenges', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))),
                            CircularPercentIndicator(
                              animateFromLastPercent: true,
                              radius: 40.0,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 3.0,
                              percent: 0.2, //0.1
                              center: new Text('${user.level}',
                                style:
                                GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15,)),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: Colors.white,
                              progressColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35,),
                      ///////////////////////////////////////////////////////////CARDIO BOX/////////////////////////////////////////////////////////////////
                      Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.green[600],
                                blurRadius: 10,
                                offset: Offset(0,7),
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Total cardio: $cardioChallenges', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35,),
                      ///////////////////////////////////////////////////////////FLEXIBILITY BOX/////////////////////////////////////////////////////////////////
                      Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.purple[200],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.purple[300],
                                blurRadius: 10,
                                offset: Offset(0,7),
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Total flexibility: $flexibilityChallenges', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35,),
                      ///////////////////////////////////////////////////////////UPPER BODY BOX/////////////////////////////////////////////////////////////////
                      Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.orange[600],
                                blurRadius: 10,
                                offset: Offset(0,7),
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Total upper body: $upperBodyChallenges', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox (height: 35,),
                      ///////////////////////////////////////////////////////////LOWER BODY BOX/////////////////////////////////////////////////////////////////
                      Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.blue[600],
                                blurRadius: 10,
                                offset: Offset(0,7),
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Total lower body: $lowerBodyChallenges', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }}