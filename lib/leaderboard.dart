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
            _leaderboard(rank: 1, email: 'Hussein denstore', lvl: 420),
            _leaderboard(rank: 2, email: 'Hamed Kaffe', lvl: 34),
            _leaderboard(rank: 3, email: 'Anton Due', lvl: 30),
            _leaderboard(rank: 4, email: 'Anton Livsen', lvl: 19),
            _leaderboard(rank: 5, email: 'Anton Due', lvl: 76),
            _leaderboard(rank: 6, email: 'Anton Due', lvl: 69),
            _leaderboard(rank: 7, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 8, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 9, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 10, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 11, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 12, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 13, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 14, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 15, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 16, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 17, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 18, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 19, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 20, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 21, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 22, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 23, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 24, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 25, email: 'Anton Due', lvl: 900),
            _leaderboard(rank: 150, email: 'You', lvl: 900),
          ],
        ),
      ),
    );
  }

  Widget _leaderboard({int rank, String email, double lvl}) {
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
