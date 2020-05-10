import 'package:sprintf/sprintf.dart'; //sprintf: https://pub.dev/packages/sprintf

class Person {
  String firstName;
  String lastName;
  double weight;
  double height;
  double age;
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
  Person(this.firstName,this.lastName,this.password,this.email,this.age,this.country,
      [this.address = "",this.region = "",this.weight = -1, this.height = -1,this.gender = "", this.username = "", this.id = 0,this.city = ""]);

  Person.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        email = json['email'],
        password = json['password'],
        username = json['username'],
        lastName = json['lastName'],
        weight = json['weight'],
        height = json['height'],
        age = json['age'],
        id = json['id'],
        gender = json['gender'],
        country = json['country'],
        region = json['region'],
        city = json['city'],
        address = json['address'];

  Map<String, dynamic> toJson() =>
      {
        'firstName': firstName,
        'email': email,
        'password': password,
        'username': username,
        'lastName': lastName,
        'weight': weight,
        'height': height,
        'age': age,
        'id': 0,
        'gender': gender,
        'country': country,
        'region': region,
        'city': city,
        'address': address,
      };
  @override
  String toString() {
    String d = sprintf("Person: [%s %s] from: %s %s is %s years old",[firstName, lastName, city, country, age, ]);
    return d;
  }
}