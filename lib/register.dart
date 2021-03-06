import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fitness_app/login.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/register_second.dart';
import 'package:google_fonts/google_fonts.dart';
import 'connection_handler.dart';
import 'utils/constants.dart';
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
  bool _obscureText = true;
  bool _obscurePassword = true;
  String error = '';
  String _password = '';
  String _email = '';
  String _confirmPass = '';

  Connection connection;

  @override
  void initState() {
    connection = widget.connection;
    super.initState();
  }
  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirm(){
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Person p;

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: (1),
        title: Text('Sign up', style: TextStyle(color: Colors.greenAccent),),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 25,),
                Text('Account creation', style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 15),
                Divider(height: 10, color: Colors.greenAccent,),
                SizedBox(height: 25,),
                ////////////////////////////////////////////////////////////////EMAIL///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => _email = val);
                    }
                ),
                SizedBox(height: 15.0),
                ////////////////////////////////////////////////////////////////PASSWORD///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField( // Remember to make a check password function
                    decoration: obscurePass.copyWith(suffixIcon: IconButton(
                      icon: Icon( Icons.lock),
                      onPressed: (){
                        _toggle();
                      },
                    ),),
                    obscureText: _obscureText,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => _password = val);
                    }
                ),
                SizedBox(height: 15.0,),
                ////////////////////////////////////////////////////////////////CONFIRM PASSWORD///////////////////////////////////////////////////////////////////////////////////////////
                TextFormField(
                  decoration: obscurePass.copyWith(hintText: 'Confirm password',suffixIcon: IconButton(
                    icon: Icon( Icons.lock),
                    onPressed: (){
                      _toggleConfirm();
                    },
                  ),),
                  obscureText: _obscurePassword,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Empty';
                    }
                    if(val != _password) {
                      return 'Not Match';
                    }
                    return null;},
                  onChanged: (val){_confirmPass = val;},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: Colors.blueGrey[900],
                      child: Text('Already on Fit2Gether? Sign in here',style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 13)),),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Login()));
                      },
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////BUTTON///////////////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 150),
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
                          setState(() {
                            p = Person('', '', _password, _email, -1, '', '', '', -1, -1, '', 0, '');
                            Navigator.of(context).push(MaterialPageRoute(builder: (
                                BuildContext context) => RegisterSecond(connection: connection, person: p,)));
                          });
                        }
                      },
                    ),
                  ],
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