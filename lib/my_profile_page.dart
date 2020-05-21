import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fitness_app/person.dart';
import 'package:flutter_fitness_app/utils/constants.dart';
import 'package:flutter_fitness_app/utils/functions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'friends.dart';
import 'loading.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'connection_handler.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class myProfilePage extends StatefulWidget {

  final Person user;
  final Connection connection;
  const myProfilePage({Key key, this.user, this.connection}) : super(key: key);

  @override
  _myProfileState createState() => _myProfileState();
}

// ignore: camel_case_types
class _myProfileState extends State<myProfilePage> {
  Person user;
  Connection connection;
  String weight;
  String height;
  bool loading = false;

  @override
  void initState() {
    user = widget.user;
    connection = widget.connection;
    super.initState();
  }

  Color bmiColor(){
    if(calculateBMI(user.weight, user.height) <= 18.5 ){
      return Colors.orange;
    }
    else if(calculateBMI(user.weight, user.height) >= 18.5 && calculateBMI(user.weight, user.height) <= 24.9){
      return Colors.green;
    }
    else if(calculateBMI(user.weight, user.height) >= 25 && calculateBMI(user.weight, user.height) <= 29.9){
      return Colors.orange;
    }
    else if(calculateBMI(user.weight, user.height) > 29.9){
      return Colors.red;
    }
  }



  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: (1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('My profile', style: TextStyle(color: Colors.white),),
            SizedBox(),
            FlatButton.icon(
              icon: Icon(
                Icons.people, color: Colors.greenAccent[400],),
              label: Text(
                '', style: TextStyle(color: Colors.white),),
              onPressed: () {
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Friends(user: user, connection: connection,)));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/coverpic.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("${user.firstName} ${user.lastName}", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 30)),),
                    SizedBox(width: 15),
                    CircularPercentIndicator(
                      animateFromLastPercent: true,
                      radius: 50.0,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 5.0,
                      percent: 0.2, //0.1
                      center: new Text('${user.level}',
                        style:
                        GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.white,
                      progressColor: Colors.greenAccent[400],
                    ),
                  ],
                ),
              ),
              Divider(height: 0, color: Colors.greenAccent[400], thickness: 2,),
              Container(
                color: Colors.greenAccent[400],
                child: Row(
                  children: <Widget>[
                    //Icon(Icons.fitness_center),
                    SizedBox(width: 1.1,),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/weight.png', height: 30, width: 30, color: Colors.greenAccent[400],),
                          Text(" ${user.weight} kg", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.blueGrey[700], fontSize: 20))),
                          IconButton(
                            icon: Icon(Icons.edit, size: 15,),
                            color: Colors.greenAccent[400],
                            onPressed: (){
                              _editWeight();
                            },
                          ),
                        ],),
                    ),
                    VerticalDivider(width:2, color: Colors.black,),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/height.png', height: 30, width: 30, color: Colors.greenAccent[400],),
                          Text(" ${user.height} cm", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: Colors.blueGrey[700], fontSize: 20))),
                          IconButton(
                            icon: Icon(Icons.edit, size: 15,),
                            color: Colors.greenAccent[400],
                            onPressed: (){
                              _editHeight();
                            },
                          ),
                        ],),
                    ),
                    VerticalDivider(width: 2, color: Color.fromRGBO(255, 0, 0, 1), thickness: 2),
                    Expanded(
                      child: Container(
                        color:  Colors.white,
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/BMI.png', height: 28, width: 28, color: bmiColor(),),
                            Text("BMI: ${calculateBMI(user.weight, user.height)}", style: GoogleFonts.ropaSans(textStyle: TextStyle(color: bmiColor(), fontSize: 20))),
                            IconButton(
                              icon: Icon(Icons.info_outline, size: 15,),
                              color: bmiColor(),
                              onPressed: (){
                                _showBmiRange();
                              },
                            ),
                          ],),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 2, color: Colors.greenAccent[400], thickness: 2,),
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                  child: Sparkline(data: <double>[0, 1, 1.5, 2, 2.5, 2, 3.5, 1.5, 1, 2.5, 2, 4],
                    sharpCorners: true,
                    lineWidth: 3,
                    lineColor: Colors.blueGrey,
                    fillMode: FillMode.below,
                    fillGradient: new LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.greenAccent[400], Colors.blue[300],
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 130.0, // (background container size) - (circle height / 2)
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profilepic.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showBmiRange() => showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.white),
        child: AlertDialog(
          backgroundColor: Colors.blueGrey[100],
          content: Container(
            width: 250,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('BMI range', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                Text('Underweight: below 18.5', style: TextStyle(color: Colors.red),),
                SizedBox(height: 10,),
                Text('Normal: 18.5 - 24.9', style: TextStyle(color: Colors.green),),
                SizedBox(height: 10,),
                Text('Overweight: 25 - 29.9', style: TextStyle(color: Colors.orange),),
                SizedBox(height: 10,),
                Text('Obese: 30 and above', style: TextStyle(color: Colors.red),),
            ]),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blueGrey[400],
              child: Text('OK', style: TextStyle(color: Colors.greenAccent[400],),),
              onPressed: (){
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      )
  );

  void _editHeight() => showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.white),
        child: AlertDialog(
          backgroundColor: Colors.blueGrey[100],
          content: Container(
            width: 250,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Edit your height', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                TextFormField(
                    decoration: textInputDecoration,
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      height = val;
                    }
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blueGrey[400],
              child: Text('Save changes', style: TextStyle(color: Colors.greenAccent[400],),),
              onPressed: () async{
                if(await connection.setHeight(height)){
                  setState(() {
                    user.height = int.parse(height);
                    Navigator.pop(context, true);
                  });
                } else{
                  Navigator.pop(context, true);
                  Text('could not set height');
                }
              },
            ),
          ],
        ),
      )
    );

  void _editWeight() => showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.white),
        child: AlertDialog(
          backgroundColor: Colors.blueGrey[100],
          content: Container(
            width: 250,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Edit your weight', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                TextFormField(
                    decoration: textInputDecoration,
                    cursorColor: Colors.green,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      weight = val;
                    }
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blueGrey[400],
              child: Text('Save changes', style: TextStyle(color: Colors.greenAccent[400],),),
              onPressed: () async{
                if(await connection.setWeight(weight)){
                  setState(() {
                    user.weight = int.parse(weight);
                    Navigator.pop(context, true);
                  });
                } else{
                  Navigator.pop(context, true);
                  Text('could not set weight');
                }
              },
            ),
          ],
        ),
      )
    );
}
