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




  @override
  void initState() {
    connection = widget.connection;
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: (1),
        title: Text('Leaderboard'),
      ),
      body:ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(height: 0,color: Colors.blueGrey[900], thickness: 10,),
              FutureBuilder(
                future: Future.wait([connection.getTop25ByRank(),connection.getLeaderBoardPosition()]),
                builder: (context, AsyncSnapshot snapshot){
                  if( snapshot.connectionState != ConnectionState.done){
                    return  Center(child: Text('Please wait its loading...'));
                  } else {
                    top25 = snapshot.data[0];//top25
                    leadRank = snapshot.data[1];//leadRank
                    listLead = top25.keys.toList();
                    leadPos = leadRank.keys.toList();
                    print("asdasdas $listLead");
                    print("asdasdas $leadPos");

                    return ListView.builder (
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
                    });}
                },
              ),
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
            ],
          ),
        ],
      ),);
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
                //Container(child: Text(leaderboardIncrement[index].toString()),),
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
        children: <Widget>[

          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("You Leaderboard position: ",style: GoogleFonts.yanoneKaffeesatz(textStyle: TextStyle(color: Color.fromRGBO(255, 253, 209, 1), fontSize: 15),)),
                ),
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
}
