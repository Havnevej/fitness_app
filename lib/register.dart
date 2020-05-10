import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';

import 'connection_handler.dart';
import 'constants.dart';
import 'loading.dart';


class Register extends StatefulWidget {

  final Connection connection;
  const Register({Key key, this.connection}) : super(key: key);


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String error = '';

  String _username = "";
  String _password = '';
  String _firstName ="";
  String  _lastName ="";
  String  _country ="";
  String  _email = "";
  String  _age = "-1";
  String _weight = "-1";
  String _height = "-1";
  String _id = "";
  String _gender = "";
  String _region = "";
  String _city="";
  String _address="";


  Connection connection;
  List<String> _genders = ['Male', 'Female', 'Non binary gender fluid'];
  String _selected_gender;
  @override
  void initState() {
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*_username.text = "ch@ruc.dk";
    _firstname.text = "anton";
    _lastname.text = "due";
    _country.text = "dk";
    _password.text = "anton123";
    _age.text = "22";*/

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: (1),
        title: Text('Sign up', style: TextStyle(color: Colors.greenAccent),),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person, color: Colors.greenAccent,),
            label: Text('Sign in', style: TextStyle(color: Colors.greenAccent),),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
            },
          ),
        ],
      ),

      body: ListView( ////changed from column to list to implement (scroll) & fix overlaoding pixels
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => _email = val);
                    }
                ),
                SizedBox(height: 15.0),
                TextFormField( // Remember to make a check password function
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => _password = val);
                    }
                ),
                SizedBox(height: 15,),
                /*TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Confirm password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                ),*/

                SizedBox(height: 15.0,),

                DropdownButton(
                  iconEnabledColor: Colors.greenAccent,
                  hint: Text('Please choose a gender'),
                  value:_selected_gender,
                  onChanged: (newValue){
                    setState(() {
                      _selected_gender = newValue;
                    });
                  },
                  items: _genders.map((location){
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
                ),

                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Firstname'),
                  cursorColor: Colors.green,
                  onChanged: (val) {
                    setState(() => _firstName = val);
                  }
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Lastname'),
                  cursorColor: Colors.green,
                    onChanged: (val) {
                      setState(() => _lastName = val);
                    }
                ),
                SizedBox(height: 15.0,),
                TextFormField( //Needs implementation
                  decoration: textInputDecoration.copyWith(hintText: 'Age'),
                  cursorColor: Colors.green,
                    onChanged: (val) {
                      setState(() => _age = val);
                    }
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Country'),
                  cursorColor: Colors.green,
                    onChanged: (val) {
                      setState(() => _country = val);
                    }
                ),

                SizedBox(height: 15.0,),

                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text(
                      'Register',
                      style: TextStyle(color: Colors.blueGrey[900])
                  ),
                  onPressed: () async {

                    if(_formkey.currentState.validate()){
                      setState(() => loading = true);
                      Person p = new Person(_firstName, _lastName, _password,_email, int.parse(_age),_country,_address,_region,double.parse(_weight),double.parse(_height),_selected_gender,_username,0,_city);
                      await connection.register(p);
                      setState(()=> loading=false);
                    }
                    print("New actionbutton clicked");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
                  },
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
