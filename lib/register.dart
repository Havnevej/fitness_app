import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';

import 'connection_handler.dart';
import 'constants.dart';
import 'loading.dart';

import 'package:flutter/cupertino.dart';

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
  String  _country = "";
  String  _email = "";
  int _age = -1;
  String _weight = "-1";
  String _height = "-1";
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

                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: DropdownButton(
                    iconEnabledColor: Colors.black,
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
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'First name'),
                  cursorColor: Colors.green,
                  onChanged: (val) {
                    setState(() => _firstName = val);
                  }
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Last name'),
                  cursorColor: Colors.green,
                    onChanged: (val) {
                      setState(() => _lastName = val);
                    }
                ),
                SizedBox(height: 15.0),

                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: FlatButton.icon(
                   icon: Icon(Icons.arrow_drop_down, color: Colors.black,), label: Text("dd/mm/yyyy",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 15),
                  ),
                    onPressed: (){
                      _showDatePicker(new DateTime.now());
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: FlatButton.icon(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black,), label: Text("Denmark",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 15),
                  ),
                    onPressed: (){
                      _showCountryPicker(new Country(isoCode: "DK"));
                    },
                  ),
                ),

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
                      Person p = new Person(_firstName, _lastName, _password,_email, _age,_country,_address,_region,double.parse(_weight),double.parse(_height),_selected_gender,_username,0,_city);
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

  void _showCountryPicker(Country initial) => showDialog(
    // flutter defined function
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
        // return object of type Dialog
        child: CupertinoAlertDialog(
          content: CountryPickerCupertino(
            pickerSheetHeight: 500,
            pickerItemHeight: 100,
            onValuePicked: (selectedCountry) {
              _country = selectedCountry.name;
            },),

        ),
      ),
    );

  void _showDatePicker(DateTime initial) => showDialog(
    // flutter defined function
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
      // return object of type Dialog
      child: CupertinoAlertDialog(
        content: SizedBox(height: 500,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime) {
              print(_age);
              setState(() {
                int daysDifference = DateTime.now().difference(dateTime).inDays;
                if(daysDifference > 0){
                  _age = (daysDifference/365).round();
                  print(_age);
                }
              });
            },
          ),
        ),
      ),
    ),
  );
}
