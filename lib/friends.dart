import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/search.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'connection_handler.dart';
import 'loading.dart';

class Friends extends StatefulWidget {
  final Person friend;
  final Person user;
  final Connection connection;

  const Friends({Key key, this.user, this.connection, this.friend}) : super(key: key);
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  bool loading = false;
  List<Person> friends =[];
  Person user;
  Connection connection;
  Stream loadFriendsData()async*{
      await connection.getMyUserData();
     for(var i = 0; i<user.friendslist.length; i++) {
      friends.add(await connection.getFriendData(user.friendslist[i]));
    }
  }
  @override
  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
    loadFriendsData();
  }

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.search, color: Colors.greenAccent,),
            label: Text("Find friends", style: TextStyle(color: Colors.greenAccent),),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Search(user: user, connection: connection,)));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
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
                    physics: ClampingScrollPhysics(),
                    itemCount: user.friendRequestsIncoming.length,
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
                                      child: Text(user.friendRequestsIncoming[index],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,)), //HARDCODE
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                    onPressed: () async{
                                      await connection.acceptFriendRequest(user.friendRequestsIncoming[index]);
                                      var friend = await connection.getFriendData(user.friendRequestsIncoming[index]);
                                      await loadFriendsData();

                                      setState(() {

                                        user.friendslist.add(friend.email);
                                        user.friendRequestsIncoming.removeAt(index);
                                        print(user.friendslist);
                                      });
                                    },
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
                                    onPressed: (){
                                      connection.declineFriendRequest(user.friendRequestsIncoming[index]);
                                      setState(() {
                                        user.friendRequestsIncoming.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),),
                          /*Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.blueGrey[900],
                            child:
                            Center(
                              child: CircularPercentIndicator(
                                animateFromLastPercent: true,
                                radius: 35.0,
                                animation: false,
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
                          ),*/
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
                title: Text('Friendslist', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent),),
                children: <Widget>[
                  StreamBuilder(
                    stream: loadFriendsData().asBroadcastStream(),
                    builder: (context, snapshot) {
                      return friends?.isEmpty ?? true ? Container():ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: user.friendslist.length,
                        itemBuilder: (BuildContext context, int index) {
                              Person friend = friends[index];
                          return Row(
                            mainAxisSize: MainAxisSize.min,
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
                                        child: Icon(Icons.person_outline, ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 17),
                                          child: Text(user.friendslist[index],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
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
                                    animation: false,
                                    animationDuration: 1200,
                                    lineWidth: 4.0,
                                    percent: (0.2), //0.1
                                    center: Text(friend?.level == null ?? true ?'':friend.level.toString(),
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.amber),
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
                      );
                    }
                  ),
                ],
              ),

              ExpansionTile(
                initiallyExpanded: false,
                backgroundColor: Colors.blueGrey[900],
                title: Text("Outgoing friends requests", style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent),),
                children: <Widget>[
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: user.friendRequestsOutgoing.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
                                    decoration:
                                    BoxDecoration(
                                      color: Colors.teal[300],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                      ),
                                    ),
                                    //color: Colors.grey[100],
                                    height:50,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(left: 20),
                                          child: Icon(Icons.arrow_forward, ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 17),
                                            child: Text(user.friendRequestsOutgoing[index],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
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