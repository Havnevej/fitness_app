import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';

import 'login.dart';


class MyProfile extends StatefulWidget {

  final Person user;
  const MyProfile({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyProfileState();
  }
}

class FitnessDefaultStyle {
  static TextStyle displayHeader(BuildContext context) {
    return Theme.of(context).textTheme.body1.copyWith(
        fontFamily: 'Yanone',fontSize: 25,color: Colors.greenAccent,fontWeight: FontWeight.bold
    );
  }
}

class MyProfileState extends State<MyProfile>{
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
          elevation: 1,
          title: Text('Fit2Gether',
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.greenAccent),
              label: Text('Logout', style: TextStyle( color: Colors.greenAccent),),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: FitnessDefaultStyle.displayHeader(context),
                        text: "Weight: ${user.weight} kg",
                      ),
                      WidgetSpan(
                        child: Icon(Icons.trending_up,color: Colors.redAccent,),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: FitnessDefaultStyle.displayHeader(context),
                        text: "Age: ${user.age}",
                      ),
                      WidgetSpan(
                        child: Icon(Icons.access_time),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: FitnessDefaultStyle.displayHeader(context),
                        text: "Country: ${user.country}",
                      ),
                      WidgetSpan(
                        child: Icon(Icons.account_balance),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: FitnessDefaultStyle.displayHeader(context),
                        text: "City: ${user.city}",
                      ),
                      WidgetSpan(
                        child: Icon(Icons.location_city),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
