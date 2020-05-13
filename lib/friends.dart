import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/search.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'connection_handler.dart';
import 'my_profile.dart';

class Friends extends StatefulWidget {
  final Person user;
  final Connection connection;

  const Friends({Key key, this.user, this.connection}) : super(key: key);
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  Person user;
  Connection connection;

  @override
  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> friendsList = <String>[];
   friendsList.add("${user.friendslist}");

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Center(
          child: Text.rich(
            TextSpan(
              style: FitnessDefaultStyle.displayHeader(context),
              text: "Hello ${user.firstName}",
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.search, color: Colors.greenAccent,),
            label: Text(""),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Search(user: user, connection: connection,)));
            },
          ),

        ],

      ),
      body: Column(
        children: <Widget>[
          ExpansionTile(
            backgroundColor: Colors.blueGrey[900],
            title: Text("Incoming friend requests", style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent),),
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user.friendRequestsIncoming.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                            Expanded(
                              child: Container(
                               child: Card(
                                  //color: Colors.blue[200],
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: ListTile(
                                            leading: const Icon(Icons.person_add),
                                            title: Text(user.friendRequestsIncoming[index],style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),),
                              ),

                            ),

                          Container(
                                padding: EdgeInsets.all(20),
                                color: Colors.blueGrey[900],
                                child:
                                Center(
                                  child: CircularPercentIndicator(
                                    animateFromLastPercent: true,
                                    radius: 35.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 4.0,
                                    percent: (0.2), //0.1
                                    center: new Text('1',
                                      style:
                                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.amber),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.square,
                                    backgroundColor: Colors.deepOrange,
                                    progressColor: Colors.orange,
                                  ),
                                ),
                          ),
                          ],
                      ),
                      Divider(height: 0,),
                      Row(
                        children: <Widget>[
                          Container(padding: EdgeInsets.only(left: 5),),
                          Expanded(
                            child: Container(
                              color:Colors.green,
                              child: FlatButton(
                                child: Text("Accept"),
                                onPressed: (){},
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color:Colors.red,
                              child: FlatButton(
                                child: Text("Deny"),
                                onPressed: (){},
                              ),
                            ),
                          ),
                          Container(padding: EdgeInsets.only(right: 80),),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: Colors.blueGrey[900],
            title: Text("Friendslist", style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent),),
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user.friendslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.blue[200],
                          child: ListTile(
                            leading: const Icon(Icons.person_outline),
                            title: Text(user.friendslist[index],style: TextStyle(fontWeight: FontWeight.bold),),
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.blueGrey[900],
                        child:
                        Center(
                          child: CircularPercentIndicator(
                            animateFromLastPercent: true,
                            radius: 35.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 4.0,
                            percent: (0.2), //0.1
                            center: new Text('1',
                              style:
                              new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.amber),
                            ),
                            circularStrokeCap: CircularStrokeCap.square,
                            backgroundColor: Colors.deepOrange,
                            progressColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          ExpansionTile(
            backgroundColor: Colors.blueGrey[900],
            title: Text("Outgoing friend requests", style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent),),
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user.friendRequestsOutgoing.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.blue[200],
                          child: ListTile(
                            leading: const Icon(Icons.person_add),
                            title: Text(user.friendRequestsOutgoing[index],style: TextStyle(fontWeight: FontWeight.bold),),
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.blueGrey[900],
                        child:
                        Center(
                          child: CircularPercentIndicator(
                            animateFromLastPercent: true,
                            radius: 35.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 4.0,
                            percent: (0.2), //0.1
                            center: new Text('1',
                              style:
                              new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.amber),
                            ),
                            circularStrokeCap: CircularStrokeCap.square,
                            backgroundColor: Colors.deepOrange,
                            progressColor: Colors.orange,
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
    );
}}



