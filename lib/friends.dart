import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/search.dart';

import 'connection_handler.dart';

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
    user = widget.connection.loggedInPerson;
    connection = widget.connection;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Text('ExpansionTile',style: TextStyle(color: Colors.greenAccent),),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.search,color: Colors.greenAccent,),
                label: Text(""),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Search()));
              },
            ),

          ],

        ),
        body: ListView.builder(

          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index],),
          itemCount: data.length,
        ),
      );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Incoming Friend Requests',
    <Entry>[
      Entry('Section A0'),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Friendslist',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Outgoing Friend Requests',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry('Section C2',),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;
  Widget _buildTiles(Entry root) {

    if (root.children.isEmpty) return ListTile(title: Text(root.title,style: TextStyle(color: Colors.greenAccent),));
    return ExpansionTile(
      backgroundColor: Colors.blueGrey[900],
      key: PageStorageKey<Entry>(root),
      title: Text(root.title,style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,color: Colors.greenAccent),),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry,);
  }
}
