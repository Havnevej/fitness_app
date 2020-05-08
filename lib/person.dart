import 'package:sprintf/sprintf.dart'; //sprintf: https://pub.dev/packages/sprintf

class Person {
  String firstName;
  String lastName;
  double weight;
  double height;
  int age;
  int id;
  String gender;
  String country;
  String region;
  String city;
  String address;
  String email;
  String username;
  String password;
  bool me = false;

  //dart magi den sætter variablerne bare ved at gøre det her
  Person(this.firstName,this.lastName,this.password,this.email,this.address,this.age,this.city,this.country,this.gender,this.height,this.id,this.region,this.username,this.weight);

  Person.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        email = json['email'],
        password = json['password'],
        lastName = json['lastName'],
        weight = json['weight'],
        height = json['height'],
        age = json['age'],
        id = json['id'],
        gender = json['gender'],
        country = json['country'],
        region = json['region'],
        city = json['city'],
        address = json['address'],
        username = json['username'];

  @override
  String toString() {
    String d = sprintf("Person: [%s %s] from: %s %s is %s years old",[firstName, lastName, city, country, age, ]);
    return d;
  }

}