import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:intl/intl.dart';

import 'connection_handler.dart';
import 'constants.dart';

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
  String  _country;
  String  _email = "";
  double _age = -1;
  String _weight = "-1";
  String _height = "-1";
  String _region = "";
  String _city="";
  String _address="";

  Connection connection;
  List<String> _genders = ['Male', 'Female', 'Other'];
  String _selected_gender;
  String dateText;
  Country _selectedCountry;

  @override
  void initState() {
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _genderText = _selected_gender == null ? "Please select a gender" : _selected_gender;
    String _dateText = dateText == null ? "dd/mm/yyyy" : dateText;
    String _countryText = _country == null ? "Please select your country" : _country;

    /*_username.text = "ch@ruc.dk";
    _firstname.text = "anton";
    _lastname.text = "due";
    _country.text = "dk";
    _password.text = "anton123";
    _age.text = "22";*/

    return Scaffold(
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => _email = val);
                    }
                ),
                SizedBox(height: 15.0),
                TextFormField( // Remember to make a check password function
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => _password = val);
                    }
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'First name'),
                  cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  onChanged: (val) {
                    setState(() => _firstName = val);
                  }
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Last name'),
                  cursorColor: Colors.green,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  onChanged: (val) {
                      setState(() => _lastName = val);
                  }
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////GENDER///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_genderText, style: TextStyle(color: _genderText == 'Please select a gender' ? Color.fromRGBO(0, 0, 0, 0.4): Color.fromRGBO(0, 0, 0, 1), fontSize: 15)),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_drop_down, color: Colors.black,),
                      ],
                    ),
                    onPressed: () {
                      _showGenderPicker();
                    },
                  ),
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////////////////////////DATE///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_dateText, style: TextStyle(color: _dateText == 'dd/mm/yyyy' ? Color.fromRGBO(0, 0, 0, 0.4): Color.fromRGBO(0, 0, 0, 1), fontSize: 15)),
                        Icon(Icons.arrow_drop_down, color: Colors.black,),
                      ],
                    ),
                    onPressed: () {
                      _showDatePicker(new DateTime.now());
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////COUNTRY///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(child: Text(_countryText, style: TextStyle(color: _countryText == 'Please select your country' ? Color.fromRGBO(0, 0, 0, 0.4): Color.fromRGBO(0, 0, 0, 1), fontSize: 15))),
                        Icon(Icons.arrow_drop_down, color: Colors.black,),
                      ],
                    ),
                    onPressed: () {
                      _showCountryPicker();
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
                    setState(() async {
                      Person p = new Person(_firstName, _lastName, _password,_email, _age,_country,_address,_region,double.parse(_weight),double.parse(_height),_selected_gender,_username,0,_city);
                      await connection.register(p);
                    });
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

  void _showCountryPicker() => showDialog(
    // flutter defined function
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
      // return object of type Dialog
      child: AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        content: SizedBox(height: 300, width: MediaQuery.of(context).size.width,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                pickerTextStyle: TextStyle(color: Colors.greenAccent, fontSize: 20),
              ),
            ),
            child: CountryPickerCupertino(
              backgroundColor: Colors.blueGrey[900],
              pickerSheetHeight: 300,
              pickerItemHeight: 100,
              initialCountry: _selectedCountry,
              onValuePicked: (selectedCountry) {
                setState(() {
                  _country = selectedCountry.name;
                  _selectedCountry = selectedCountry;
                });
              },
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.greenAccent,
            child: Text('OK', style: TextStyle(color: Colors.blueGrey[900],),),
            onPressed: (){
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    ),
  );

  void _showDatePicker(DateTime initial) => showDialog(
    // flutter defined function
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
      // return object of type Dialog
      child: AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        content: SizedBox(height: 300, width: MediaQuery.of(context).size.width,
          child: CupertinoTheme(
            data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(color: Colors.greenAccent, fontSize: 20),
              ),
            ),
              child: CupertinoDatePicker(
              backgroundColor: Colors.blueGrey[900],
              initialDateTime: DateTime(2007),
              minimumDate: DateTime(1920),
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime) {
              setState(() {
                int daysDifference = DateTime.now().difference(dateTime).inDays;
                if(daysDifference > 0){
                  _age = daysDifference/365;
                  var formatter = new DateFormat('dd/MM/yyyy');
                  dateText = formatter.format(dateTime);
                }
              });
            },
          ),
            ),
          ),
        actions: <Widget>[
            FlatButton(
              color: Colors.greenAccent,
              child: Text('OK', style: TextStyle(color: Colors.blueGrey[900],),),
              onPressed: (){
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
  );

  void _showGenderPicker() => showDialog(
    // flutter defined function
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.greenAccent),
      // return object of type Dialog
      child: AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        content: Container(
          width: 300,
          height: 200,
          child: ListView(
            children: _genders.map((location){
              return Card(
                color: Colors.blueGrey[900],
                margin: EdgeInsets.all(0),
                shape: ContinuousRectangleBorder(),
                child: ListTile(
                  onTap: (){
                    setState(() {
                      _selected_gender = location;
                      Navigator.pop(context, true);
                    });
                  },
                  title: Center(child: Text(location, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.greenAccent),)),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}
