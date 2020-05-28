
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/localsave.dart';
import 'package:flutter_fitness_app/utils/constants.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'connection_handler.dart';

class Search extends StatefulWidget {
  final Person user;
  final Connection connection;

  const Search({Key key,this.connection, this.user}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Person user;
  Connection connection;
  List list2=[];
  Map<String, dynamic> _map;

  @override
  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("Find friends",style: TextStyle(color: Colors.greenAccent),),
        backgroundColor: Colors.blueGrey[900],
        elevation: 1,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Search',),
                        onChanged: (val) async {
                            _map = await connection.searchByEmail(val);
                            setState(() {
                              list2 = _map.keys.toList();
                            });
                        }
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(height: 7,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Container(
                                        padding: EdgeInsets.all(20),
                                        child:
                                        Center(
                                          child: CircularPercentIndicator(
                                            animateFromLastPercent: true,
                                            radius: 35.0,
                                            animation: false,
                                            animationDuration: 1200,
                                            lineWidth: 4.0,
                                            percent: (0.2), //0.1
                                            center: Text(_map[list2[index]], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.purple[900]),
                                            ),
                                            circularStrokeCap: CircularStrokeCap.square,
                                            backgroundColor: Colors.deepOrange,
                                            progressColor: Colors.orange,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container (
                                          height: 20,
                                          child: Text(list2[index],style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),), //${_map.toString()[index]}
                                        ),
                                      ),
                                      Container(
                                        width:60,
                                        margin: const EdgeInsets.only(right: 0),
                                        child: FlatButton.icon(
                                          padding: EdgeInsets.only(left:20),
                                          label: Text(''),
                                          icon: Icon(Icons.person_add),
                                        onPressed: (){
                                            _showbuttons(list2[index], index);
                                        },),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () async{
                                  await connection.getFriendData(list2[index]);
                                  _showbuttons(list2[index], index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );}
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _showbuttons(String email, int index) => showDialog(context: context, builder: (context) =>

   Material(
     type: MaterialType.transparency,
     child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            decoration: BoxDecoration(
              color: Colors.teal[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(20),
              ),),
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(child: Text(email,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 0, color: Colors.black, indent: 50, endIndent: 50,),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(0),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(0),
              ),),
            height: 70,
            //color: Colors.greenAccent,
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   // color: Colors.green,
                   child:FlatButton.icon(
                     padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                     label: Text("Send friend request", style: TextStyle(fontSize: 15),),
                     icon: Icon(Icons.person_add,color: Colors.blueGrey[900],),
                      onPressed:() {
                        LocalSave.save('${user.email}notifications', email);
                        connection.sendFriendRequest(email);
                        Navigator.pop(context);
                        setState(() {
                          list2.removeAt(index);
                          user.friendRequestsOutgoing.add(email);
                        });
                      },
                ),),
                ),
                VerticalDivider(width:12, color: Colors.black,),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   child:FlatButton.icon(
                     padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                     icon: Icon(Icons.not_interested, color: Colors.blueGrey[900]),
                     label: Text('Cancel', style: TextStyle(fontSize: 15, color: Colors.blueGrey[900]),),
                       onPressed: () {
                       Navigator.pop(context);},
                ),
                ),
                ],
            ),
          ),
        ],
      ),
   ),
  );
}





