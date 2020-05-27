import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'connection_handler.dart';


class LeaderBoard extends StatefulWidget {

  final Connection connection;
  final Person user;
  const LeaderBoard({Key key, this.user, this.connection}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeaderBoardState();
  }
}

class _LeaderBoardState extends State<LeaderBoard> {
  Person user;
  Connection connection;
  List listLead=[];
  List leadPos=[];
  Map<dynamic, dynamic> top25;
  Map<dynamic, dynamic> leadRank; //

  List<int> leaderboardIncrement = [] ;

  Stream streamTop25()async*{
    top25 = await connection.getTop25ByRank();
    listLead = top25.keys.toList();

    leadRank = await connection.getLeaderBoardPosition();
    leadPos = leadRank.keys.toList();

    for(int i = 1; i<listLead.length+1; i++){
      leaderboardIncrement.add(i);
    }
  }

  @override
  void initState() {
    connection = widget.connection;
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: (1),
        title: Text('Leaderboard'),
      ),
      body:ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey[900],
                      child: Center(
                        child: Text('Your Leaderboard placing in Denmark', style: TextStyle(fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: streamTop25(),
                builder: (context, AsyncSnapshot snapshot){
                  return Column(
                    children: [
                      ListView.builder (
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: leadPos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _leaderboardPos(email: leadPos[index], lvl: leadRank[leadPos[index]]);
                        }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.blueGrey[800],
                              child: Center(
                                child: Text('Global TOP 10', style: TextStyle(fontSize: 20,
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold
                                ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder (
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listLead.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    color:Colors.blueGrey[900],
                                    child: _leaderboard(email: listLead[index], lvl: top25[listLead[index]], index: index),
                                  ),
                                ],
                              );
                      }),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leaderboard({String email, int lvl, int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(child: Text(leaderboardIncrement[index].toString()),),
                Center(
                  child: Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Text(email, style: GoogleFonts.yanoneKaffeesatz(textStyle: TextStyle(color: Color.fromRGBO(255, 253, 209, 1), fontSize: 15),))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Text("$lvl", style: TextStyle(fontWeight: FontWeight.bold),),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 2, color: Color.fromRGBO(255, 253, 209, 1),),
        ],
      ),
    );
  }

  Widget _leaderboardPos({String email, int lvl,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(3, 3, 0, 0),
                            child: Text("${email.toUpperCase()}", style: GoogleFonts.yanoneKaffeesatz(textStyle: TextStyle(color: Colors.black54, fontSize: 35, fontWeight: FontWeight.bold),))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        width: 45,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        child: Center(child: Text("#$lvl", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
