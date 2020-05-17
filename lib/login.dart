import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/home.dart';
import 'package:flutter_fitness_app/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'connection_handler.dart';
import 'utils/constants.dart';
import 'loading.dart';
import 'person.dart';

Socket socket;
Connection _server_connection = new Connection();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formkey = GlobalKey<FormState>();
  bool login = false;
  var txt = TextEditingController();
  String username;
  String password;
  bool loading = false;
  String name;
  String error='';
  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 1.0,
        title: Text('Fit2Gether',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
        CircleAvatar(
          radius: 140,
          backgroundImage: NetworkImage('https://is4-ssl.mzstatic.com/image/thumb/Podcasts113/v4/77/57/32/7757329d-e5cb-f401-3576-ed3c2e86988b/mza_2306268303586606653.jpg/600x600bb.jpg'),
        ),
        Divider(height: 30, color: Colors.greenAccent,),
      Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => username = val);
                }
            ),
            SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                }
            ),

            SizedBox(height: 20,),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              color: Colors.greenAccent,
              onPressed: () async {
                if(_formkey.currentState.validate()){
                  setState(()=> loading = true);
                  if(await _server_connection.loginUser(username, password)){

                    List challenges = await _server_connection.getChallenges();
                    print(challenges[0]["title"]);
                    //Uncomment these to test features on login
                    /*
                    //Gets the 1st challenge and gets the point reward from it
                    _server_connection.completeChallenge(jsonEncode(challenges[0]));
                    Get top 25 sorted by level
                    _server_connection.getTop25ByRank();
                    Accept and decline friends request, if the friend is not in the friend requests it will throw an error
                    bool did_accept = await _server_connection.declineFriendRequest("hkmiari@ruc.dk");
                    bool did_decline = await _server_connection.declineFriendRequest("hkmiari@ruc.dk");
                    print(did_accept);
                    print(did_decline);
                    Map<String, dynamic> results = await _server_connection.searchByEmail("ant");
                     */

                    setState(() {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home(connection: _server_connection)));
                    });
                  }else{
                    setState(() => loading = false);
                    setState(() => error = 'could not sign in with those credentials');
                  }
                }
              },
              child: Text("Login"),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('New to the app? Sign up here',style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 13)),),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Register(connection: _server_connection,)));
                    },
                  ),
                  ],
              ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    ],
      ),
    );
  }
}
