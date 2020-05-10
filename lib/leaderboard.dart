import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';

class LeaderBoard extends StatefulWidget {
  final Person user;
  const LeaderBoard({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeaderBoardState();
  }
}

 /* @override
  _LeaderBoardState createState() => _LeaderBoardState();
}*/

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
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Leaderboard'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 25,),
          Center(
            child: Container(
              child: Text('Leaderboard', style: TextStyle(color: Colors.greenAccent),),

            ),
          ),
          Divider(color: Colors.greenAccent,height: 30,),
          Row(
            children: <Widget>[
              Icon(Icons.info, color: Colors.greenAccent,),
              Container(color: Colors.greenAccent, child: Text('ASDASD'),),
            ],
          ),
        ],
      ),
    );
  }
}
