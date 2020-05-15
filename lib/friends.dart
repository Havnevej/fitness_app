import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/search.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'connection_handler.dart';
import 'loading.dart';
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
  bool loading = false;
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

    return loading ? Loading() : Scaffold(
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[300],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                topLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                              ),
                            ),
                            height: 30,
                            //width: 20,
                            //color:Colors.green,
                            child: FlatButton(
                              child: Text("Accept"),
                              onPressed: (){},
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red[800],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                topLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                              ),
                            ),
                            height: 30,
                            //width: 20,
                            //color:Colors.red,
                            child: FlatButton(
                              child: Text("Deny"),
                              onPressed: (){},
                            ),
                          ),
                        ],
                      ),),
                      Expanded(
                        child: Container(
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
                          height:65,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Icon(Icons.person_add, ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 17),
                                  child: Text(user.friendRequestsIncoming[index],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),
                              ),
                            ],
                          ),
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

                      Divider(height: 0,),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration:
                          BoxDecoration(
                            color: Colors.teal[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          //color: Colors.grey[100],
                          height:65,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.person_add, ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 17),
                                  child: Text(user.friendslist[index],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),
                              ),
                            ],
                          ),
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
                  );
                },
              ),
            ],
          ),

          ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: Colors.blueGrey[900],
            title: Text("Outgoing friends requests", style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent),),
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user.friendRequestsOutgoing.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration:
                          BoxDecoration(
                            color: Colors.teal[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          //color: Colors.grey[100],
                          height:65,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.person_add, ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 17),
                                  child: Text(user.friendRequestsOutgoing[index],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),
                              ),
                            ],
                          ),
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
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
}}



