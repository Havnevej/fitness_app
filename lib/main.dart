import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';
import 'dart:io';
import 'connection_handler.dart';
import 'my_profile.dart';

Socket socket;
Connection _server_connection = new Connection();

void main() => runApp(MaterialApp(
  home: Home(),
  title: "123",
));

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HeaderWidget extends StatelessWidget implements PreferredSizeWidget{
  final String headerText;
  final AppBar appBar;

  const HeaderWidget({Key key, this.headerText, this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text(
        'HAH! $headerText',
        style: TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.blueGrey,
          fontFamily: 'Yanone',
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.greenAccent,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
class HomeState extends State<Home> {
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

  String name;
  @override
  Widget build(BuildContext context) {
    txtUsername.text = "ch@ruc.dk";
    _firstname.text = "anton";
    _lastname.text = "due";
    _country.text = "dk";
    _email.text = "hussein123333@ruc.dk";
    _password.text = "anton123";
    _age.text = "22";
    print(_server_connection.loggedIn);
    return Scaffold(
      appBar: new HeaderWidget(
        headerText: "Fitness",
        appBar: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "username",
                    ),
                    cursorColor: Colors.green,
                    controller: txtUsername,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
                    cursorColor: Colors.green,
                    controller: txtPassword,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Divider(
            color: Colors.black38,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Logged in"),
                    Checkbox(
                      value: _server_connection.loggedIn,
                    ),
                    ],
                  ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.black12,
                child: Image(
                  width: 25,
                  height: 25,
                  image: AssetImage("assets/images/runner262x263.png"),
                ),
              ),

              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                color: Colors.black12,
                onPressed: () async {
                  await _server_connection.loginUser(txtUsername.text,txtPassword.text);
                  setState(() {
                    if(_server_connection.loggedIn){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyProfile(user: _server_connection.loggedInPerson)));
                    }
                  });
                },
                child: Text("Something"),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextField(
                    maxLengthEnforced: true,
                    maxLines: 5,
                    enabled: false,
                    controller: _bigBoxController,
                  ),
                ),
              )
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Firstname",
            ),
            cursorColor: Colors.green,
            controller: _firstname,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Lastname",
            ),
            cursorColor: Colors.green,
            controller: _lastname,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "email",
            ),
            cursorColor: Colors.green,
            controller: _email,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "age",
            ),
            cursorColor: Colors.green,
            controller: _age,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "countrycode",
            ),
            cursorColor: Colors.green,
            controller: _country,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "password",
            ),
            cursorColor: Colors.green,
            controller: _password,
          ),
        ],
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("New actionbutton clicked");
          Person p = new Person(_firstname.text, _lastname.text, _password.text, _email.text, int.parse(_age.text), _country.text);
          bool register = await _server_connection.register(p);
          setState(() {
            _showDialog(p, register);
          });
        } ,
        child: Text(
          'Dette er den nye knap',
          style: TextStyle(
            fontFamily: 'Yanone',
          ),
        ),
      ),
      );
  }
  // user defined function
  void _showDialog(Person p, bool register) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Register $register"),
          content: new Text("Tried to register ${p.email} response was $register"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
