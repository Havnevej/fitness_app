import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';


class LeaderBoard extends StatefulWidget {
  final Person user;
  const LeaderBoard({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeaderBoardState();
  }
}

class _LeaderBoardState extends State<LeaderBoard> {
  Person user;

  @override
  void initState() {
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
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text('TOP 25', style: TextStyle(fontSize: 20,
                  color: Color.fromRGBO(255, 253, 209, 1),
                  fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 20),
            _leaderboardWidget(rank: 1, name: 'Hussein denstore', lvl: 420),
            _leaderboardWidget(rank: 2, name: 'Hamed Kaffe', lvl: 34),
            _leaderboardWidget(rank: 3, name: 'Anton Due', lvl: 30),
            _leaderboardWidget(rank: 4, name: 'Anton Livsen', lvl: 19),
            _leaderboardWidget(rank: 5, name: 'Anton Due', lvl: 76),
            _leaderboardWidget(rank: 6, name: 'Anton Due', lvl: 69),
            _leaderboardWidget(rank: 7, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 8, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 9, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 10, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 11, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 12, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 13, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 14, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 15, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 16, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 17, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 18, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 19, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 20, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 21, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 22, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 23, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 24, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 25, name: 'Anton Due', lvl: 900),
            _leaderboardWidget(rank: 150, name: 'You', lvl: 900),
          ],
        ),
      ),
    );
  }

  Widget _leaderboardWidget({int rank, String name, double lvl}) {
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
                    child: Text("$rank", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),)),
                Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(name, style: GoogleFonts.yanoneKaffeesatz(textStyle: TextStyle(color: Color.fromRGBO(255, 253, 209, 1), fontSize: 15),))),
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
