import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/search.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'connection_handler.dart';

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

  @override
  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
  }

  void load_challenges_completed() async{
    List temp = await connection.getChallenges();
    setState(() {
      challenges = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              ExpansionTile(
                backgroundColor: Colors.blueGrey[900],
                title: Text("Challenge type x", style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent),),
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: user.challengesCompleted.bitLength,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left:10),
                              decoration:
                              BoxDecoration(
                                color: Colors.teal[300],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  topLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              //color: Colors.grey[100],
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
        ],
      ),
    );
  }}