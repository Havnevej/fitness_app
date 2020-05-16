import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/utils/constants.dart';
import 'package:flutter_fitness_app/person.dart';

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
                  shrinkWrap: true,
                  itemCount: list2.length,
                  itemBuilder: (BuildContext context, int index) {
                    print('Test $list2');
                    return Column(
                      children: [
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container (
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                height: 60,
                                color: Colors.greenAccent,
                                child: Center(
                                  child: Text(list2[index],style: TextStyle(color: Colors.red),)), //${_map.toString()[index]}
                              ),
                            ),
                            Container (
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              height: 60,
                              color: Colors.greenAccent,
                              child: Center(
                                  child: Text(_map[list2[index]],style: TextStyle(color: Colors.red),)), //${_map.toString()[index]}
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
