import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/constants.dart';


class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}
class Friends extends StatefulWidget {
  final String title;
  final String body;
  const Friends({Key key, this.title, this.body}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;

  List<String>friends;



  Future<List<Post>> search(String text) async {
    await Future.delayed(Duration(seconds: 1));

    //if (isReplay) return [Post("Replaying !", "Replaying body")];
    //if (text.length == 5) throw Error();
    //if (text.length == 6) return [];

    List<String>friends =["Toinker","Toink",'Amazing','Line','Hamed'];

    List<Post> posts = [Post("Line","TandPineasdasdasd"),Post("Anton Due", "Elsker også kage"),Post("Hussein Miari", "Elsker kage"),Post("Hamed Vadai", "Elsker også kageee")];
    
    friends.where((friend)=> friend.startsWith('A'));
    /*var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }*/
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: SearchBar<Post>(
          hintText: "Search",
          textStyle: TextStyle(color: Colors.greenAccent),
          iconActiveColor: Colors.greenAccent,
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: search,
          searchBarController: _searchBarController,
          placeHolder: Text("placeholder",),
          cancellationWidget: Text("Cancel",style: TextStyle(color: Colors.greenAccent),),
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(2,0.4), // How results look
          header: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                color: Colors.blueGrey[900],
                child: Text("sort",style: TextStyle(color: Colors.greenAccent),),
                onPressed: () {
                  //friends.where((friend)=> friend.startsWith('A'));
                  _searchBarController.sortList((Post a, Post b) {
                    return a.body.compareTo(b.body);
                  });
                },
              ),
              RaisedButton(
                color: Colors.blueGrey[900],
                child: Text("Desort",style: TextStyle(color: Colors.greenAccent),),
                onPressed: () {
                  _searchBarController.removeSort();
                },
              ),
              RaisedButton(
                color: Colors.blueGrey[900],
                child: Text("Replay",style: TextStyle(color: Colors.greenAccent),),
                onPressed: () {
                  isReplay = !isReplay;
                  _searchBarController.replayLastSearch();
                },
              ),
            ],
          ),

          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            return Container(
              color: Colors.greenAccent,
              child: ListTile(
                title: Text(post.title),
                isThreeLine: true,
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
        ),
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