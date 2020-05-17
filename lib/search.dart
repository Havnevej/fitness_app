import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
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


    //Map<String, dynamic> _map = {'':'',};
    //setState(() =>list =_map.values.toList());
   // setState(() =>list2.add(_map.keys.toList()));
    //list2 = _map.keys.toList();
    //list2.add(_map.keys.toList());
    List people=[];
    for(int i=0; i<10; i++){
    people.add(i.toString());
    }
    String search ="";
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
                    print('Test $list2');
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
                                        margin: const EdgeInsets.only(left: 20),
                                        child: Icon(Icons.person),
                                      ),
                                      Expanded(
                                        child: Container (
                                          height: 60,
                                          child: Center(child: Text(list2[index],style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),)), //${_map.toString()[index]}
                                        ),
                                      ),
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
                                    ],
                                  ),
                                ),
                                onPressed: () async{
                                  await connection.getFriendData(list2[index]);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detail()),);
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
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
