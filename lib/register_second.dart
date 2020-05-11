import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/register_third.dart';

import 'connection_handler.dart';
import 'constants.dart';

import 'package:flutter/cupertino.dart';


class RegisterSecond extends StatefulWidget {

  final Connection connection;
  final Person person;
  const RegisterSecond({Key key, this.connection, this.person}) : super(key: key);

  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String error = '';

  String _country;
  String _region = "";
  String _city="";
  String _address="";
  Person p;

  Connection connection;
  String dateText;
  Country _selectedCountry;

  @override
  void initState() {
    p = widget.person;
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String _countryText = _country == null ? "Please select your country" : _country;
    //String _countryError = _selectedCountry == null ? "Please select your country": '1';

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: (1),
        title: Text('Previous page', style: TextStyle(color: Colors.greenAccent),),
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
                SizedBox(height: 5,),
                Text('Personal information', style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 15),
                Divider(height: 10, color: Colors.greenAccent,),
                SizedBox(height: 25,),
                ////////////////////////////////////////////////////////////////FIRSTNAME///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'First name'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter a name' : null,
                    onChanged: (val) {
                      setState(() => p.firstName = val);
                    }
                ),
                SizedBox(height: 15.0,),
                ////////////////////////////////////////////////////////////////LASTNAME///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Last name'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter a last name' : null,
                    onChanged: (val) {
                      setState(() => p.lastName = val);
                    }
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////COUNTRY///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    elevation: 10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(child: Text(_countryText, style: TextStyle(color: _countryText == 'Please select your country' ? Color.fromRGBO(0, 0, 0, 0.5): Color.fromRGBO(0, 0, 0, 1), fontSize: 15, fontWeight: FontWeight.bold))),
                        Icon(Icons.arrow_drop_down, color: Colors.black,),
                      ],
                    ),
                    onPressed: () {
                      _showCountryPicker();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //Text(_countryError, style: TextStyle(color: Colors.red),
                    //),
                  ],
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////REGION///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Region'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter your region' : null,
                    onChanged: (val) {
                      setState(() => p.region = val);
                    }
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////CITY///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'City'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter your city' : null,
                    onChanged: (val) {
                      setState(() => p.city = val);
                    }
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////Address///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Address'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter your address' : null,
                    onChanged: (val) {
                      setState(() => p.address = val);
                    }
                ),
                SizedBox(height: 20),
                ////////////////////////////////////////////////////////////////BUTTON///////////////////////////////////////////////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.greenAccent,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_forward, color: Colors.blueGrey[900],),
                        ],
                      ),
                      onPressed: () {
                        if(_formkey.currentState.validate()){
                            Navigator.of(context).push(MaterialPageRoute(builder: (
                                BuildContext context) => RegisterThird(person: p,)));
                        }
                      },
                    ),
                  ],
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
              onValuePicked: (selectedCountry) {
                setState(() {
                  _country = selectedCountry.name;
                  _selectedCountry = selectedCountry;
                  p.country = _country;
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
}