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
  Map<dynamic, dynamic> _map;

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
            children: <Widget>[
              Center(
                child: Text('TOP 25', style: TextStyle(fontSize: 20,
                    color: Color.fromRGBO(255, 253, 209, 1),
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
              FutureBuilder<Map<dynamic,dynamic>>(
                future: connection.getTop25ByRank(),
                builder: (BuildContext context, AsyncSnapshot<Map<dynamic,dynamic>>snapshot){
                  if( snapshot.connectionState != ConnectionState.done){
                    return  Center(child: Text('Please wait its loading...'));
                  } else {
                    print("asdasd ${snapshot.data}");
                    _map = snapshot.data;
                    listLead = _map.keys.toList();
                  return ListView.builder (
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listLead.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            _leaderboard(email: listLead[index], lvl: _map[listLead[index]]),
                          ],
                        );
                      });}
                },
              ),
            ],
          ),
        ],
      ),);
  }

  Widget _leaderboard({String email, int lvl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Container(height: 2, color: Color.fromRGBO(255, 253, 209, 1),),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(email, style: GoogleFonts.yanoneKaffeesatz(textStyle: TextStyle(color: Color.fromRGBO(255, 253, 209, 1), fontSize: 15),))),
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
        ],
      ),
    );
  }
}
