import 'package:sprintf/sprintf.dart';

class Person {
  String firstName;
  String lastName;
  int weight;
  int height;
  int age;
  int id;
  int exp;
  int level;
  String gender;
  String country;
  String region;
  String city;
  String address;
  String email;
  String username;
  String password;
  List<String> friendslist;
  List<String> friendRequestsIncoming;
  List<String> friendRequestsOutgoing;
  String registerDate;
  int challengesCompleted;

  Person(this.firstName,this.lastName,this.password,this.email,this.age,this.country,
      [this.address = "",this.region = "",this.weight = -1, this.height = -1,this.gender = "", this.id = 0,this.city = "", this.level = -1]);

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
        address = json['address'],
        exp = json['exp'],
        level = json['level'],
        registerDate = json['registerDate'],
        friendslist = (json['friendslist'] as List<dynamic>).cast<String>(),
        friendRequestsIncoming = (json['friendRequestsIncoming'] as List<dynamic>).cast<String>(),
        friendRequestsOutgoing = (json['friendRequestsOutgoing'] as List<dynamic>).cast<String>(),
        challengesCompleted = json['challengesCompleted'];

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
        'exp':exp,
        'level':level,

      };
  @override
  String toString() {
    var d = sprintf('%s t %s i %s s s %s e %s m %s a %s n %s d %s h %s e %s h %s e %s',[firstName, lastName, password,  email, weight, height, age, gender, country, region, city, address, id]);
    return d;
  }
}