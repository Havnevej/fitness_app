import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:intl/intl.dart';
import 'connection_handler.dart';
import 'utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'loading.dart';

class RegisterThird extends StatefulWidget {
  final Connection connection;
  final Person person;
  const RegisterThird({Key key, this.connection, this.person}) : super(key: key);

  @override
  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends State<RegisterThird> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';
  bool errorOn = false;
  double weight = -1;
  double height = -1;
  String gender = "";
  Person p;
  int _age = -1;
  Connection connection;
  List<String> _genders = ['Male', 'Female', 'Other'];
  String _selected_gender;
  String dateText;

  @override
  void initState() {
    p = widget.person;
    connection = widget.connection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String _genderText = _selected_gender == null ? "Please select a gender" : _selected_gender;
    String _dateText = dateText == null ? "Age: dd/mm/yyyy" : dateText;

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: (1),
        title: Text('Previous page', style: TextStyle(color: Colors.greenAccent),),
        actions: <Widget>[
          /*FlatButton.icon(
            icon: Icon(
              Icons.person, color: Colors.greenAccent,),
            label: Text('Sign in', style: TextStyle(color: Colors.greenAccent),),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
            },
          ),*/
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
                ////////////////////////////////////////////////////////////////GENDER///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    elevation: 10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_genderText, style: TextStyle(color: _genderText == 'Please select a gender' ? Color.fromRGBO(0, 0, 0, 0.5): Color.fromRGBO(0, 0, 0, 1), fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_drop_down, color: Colors.black,),
                      ],
                    ),
                    onPressed: () {
                      _showGenderPicker();
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////AGE///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    elevation: 10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_dateText, style: TextStyle(color: _dateText == 'Age: dd/mm/yyyy' ? Color.fromRGBO(0, 0, 0, 0.5): Color.fromRGBO(0, 0, 0, 1), fontSize: 15, fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_drop_down, color: Colors.black,),
                      ],
                    ),
                    onPressed: () {
                      _showDatePicker(new DateTime.now());
                    },
                  ),
                ),
                SizedBox(height: 15.0,),
                ////////////////////////////////////////////////////////////////HEIGHT///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Height'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      setState(() => p.height = int.parse(val));
                    }
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////WEIGHT///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Weight'),
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      setState(() => p.weight = int.parse(val));
                    }
                ),
                SizedBox(height: 80,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(error,style: TextStyle(color: Colors.red,),),
                  ],
                ),
                SizedBox(height: 35),
                ////////////////////////////////////////////////////////////////BUTTON///////////////////////////////////////////////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.greenAccent,
                      child: Text(
                          'Register',
                          style: TextStyle(color: Colors.blueGrey[900])
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        if(await connection.register(p)){
                          setState(() {
                            //loading = false;
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
                          });
                        } else {
                          setState(() => loading = false);
                          setState(() => error = 'Email is either invalid or already taken.');
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////DatePicker///////////////////////////////////////////////////////////////////////////////////////////
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
                    _age = (daysDifference/365).round();
                    var formatter = new DateFormat('dd/MM/yyyy');
                    dateText = formatter.format(dateTime);
                    p.age = _age;
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
                      p.gender = location;
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