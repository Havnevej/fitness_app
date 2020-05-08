import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/person.dart';

import 'main.dart';

class MyProfile extends StatefulWidget {
  final Person user;

  const MyProfile({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyProfileState();
  }
}

class FitnessDefaultStyle {
  static TextStyle displayHeader(BuildContext context) {
    return Theme.of(context).textTheme.body1.copyWith(
        fontFamily: 'Yanone',fontSize: 25,color: Colors.greenAccent,fontWeight: FontWeight.bold
    );
  }
}

class MyProfileState extends State<MyProfile>{
  Person user;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        headerText: "${user.firstName}",
        appBar: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: FitnessDefaultStyle.displayHeader(context),
                            text: "Weight: ${user.weight} kg",
                          ),
                          WidgetSpan(
                            child: Icon(Icons.trending_up,color: Colors.redAccent,),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: FitnessDefaultStyle.displayHeader(context),
                            text: "Age: ${user.age}",
                          ),
                          WidgetSpan(
                            child: Icon(Icons.access_time),
                          ),
                        ],
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }

}