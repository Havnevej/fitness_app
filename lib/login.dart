import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/home.dart';
import 'package:flutter_fitness_app/my_profile.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/register.dart';

import 'connection_handler.dart';
import 'constants.dart';
import 'loading.dart';
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
  var txtUsername = TextEditingController();
  var txtPassword = TextEditingController();
  var _bigBoxController = TextEditingController();
  var _firstname = TextEditingController();
  var _lastname = TextEditingController();
  var _country = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _age = TextEditingController();
  bool loading = false;
  String name;
  String error='';
  @override
  Widget build(BuildContext context) {
    txtUsername.text = "ch@ruc.dk";
    _firstname.text = "anton";
    _lastname.text = "due";
    _country.text = "dk";
    _email.text = "anton@ruc.dk";
    _password.text = "anton123";
    _age.text = "22";
    print(_server_connection.loggedIn);

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
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
            label: Text('Register', style: TextStyle( color: Colors.greenAccent),),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Register(connection: _server_connection,)));

            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
      Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => txtUsername.text = val);
                }
            ),
            SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => txtPassword.text = val);
                }
            ),

            SizedBox(height: 20,),

            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              color: Colors.greenAccent,
              onPressed: () async {
                if(_formkey.currentState.validate()){
                  setState(()=> loading = true);

                  if(await _server_connection.loginUser(txtUsername.text,txtPassword.text)){
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
            SizedBox(height: 10,),
          ],
        ),
      ),
    ],
      ),
    );
  }
}
