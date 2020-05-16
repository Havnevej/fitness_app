import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'loading.dart';
import 'connection_handler.dart';
import 'package:google_fonts/google_fonts.dart';

class Challenges extends StatefulWidget {

  final Person user;
  final Connection connection;
  const Challenges({Key key, this.user, this.connection}) : super(key: key);

  @override
  _challengesState createState() => _challengesState();
}

class _challengesState extends State<Challenges> {
  Person user;
  Connection connection;
  @override
  bool loading = false;
  bool _visible = true;
  bool boxCheck1 = false;
  bool boxCheck2 = false;
  bool boxCheck3 = false;
  bool boxCheck4 = false;

  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: (1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Daily challenges', style: TextStyle(color: Colors.white),),
            SizedBox(),
            FlatButton.icon(
              icon: Icon(
                Icons.exit_to_app, color: Colors.white,),
              label: Text(
                'Log out', style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Login()));
              },
            ),
          ],
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 30.0,
          ),
              child: Column(
          children: <Widget>[
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
                      color: Colors.blueGrey[600],
                      blurRadius: 10,
                      offset: Offset(0,10),
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Challenges completed: ${user.challengesCompleted}', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))),
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
           Container(
                height: 80,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.blueGrey[600],
                        blurRadius: 10,
                        offset: Offset(0,10),
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Challenge 1', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                        Text('Description: Do 10 push ups'),
                        Text('Reward: 200 points'),
                      ],
                    ),
                    Checkbox(
                      value: boxCheck1,
                      checkColor: Colors.green,
                      activeColor: Colors.white,
                      onChanged: (bool newValue){
                        setState(() {
                          boxCheck1 = newValue;
                          if(boxCheck1 == true){
                            user.challengesCompleted++;
                          }
                          else{
                            user.challengesCompleted--;
                          }
                        });
                      },
                    ),
                  ],
                ),
            ),
            SizedBox(height: 35,),
            Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.blueGrey[600],
                      blurRadius: 10,
                      offset: Offset(0,10),
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Challenge 2', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                      Text('Description: Run 4 km'),
                      Text('Reward: 500 points'),
                    ],
                  ),
                  Checkbox(
                    value: boxCheck2,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: (bool newValue){
                      setState(() {
                        boxCheck2 = newValue;
                        if(boxCheck2 == true){
                          user.challengesCompleted++;
                        }
                        else{
                          user.challengesCompleted--;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 35,),
            Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.blueGrey[600],
                      blurRadius: 10,
                      offset: Offset(0,10),
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Challenge 3', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                      Text('Description: Do 50 push ups and run 4 km'),
                      Text('Reward: 800 points'),
                    ],
                  ),
                  Checkbox(
                    value: boxCheck3,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: (bool newValue){
                      setState(() {
                        boxCheck3 = newValue;
                        if(boxCheck3 == true){
                          user.challengesCompleted++;
                        }
                        else{
                          user.challengesCompleted--;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 35,),
            Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.blueGrey[600],
                      blurRadius: 10,
                      offset: Offset(0,10),
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Challenge 4', style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                      Text('Description: Do 200 push ups'),
                      Text('Reward: 1150 points'),
                    ],
                  ),
                  Checkbox(
                    value: boxCheck4,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: (bool newValue){
                      setState(() {
                        boxCheck4 = newValue;
                        if(boxCheck4 == true){
                          user.challengesCompleted++;
                        }
                        else{
                          user.challengesCompleted--;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
      ),
      ),
    );
  }
}
