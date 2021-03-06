import 'dart:convert' show utf8;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_fitness_app/person.dart';

class Connection {
  SecureSocket socket;
  final int _port = 9001;
  final String _address = "192.168.8.102"; // 192.168.8.102
  bool server_online = false;
  bool cert_loaded = false;
  final bool _verbose = false;
  SecurityContext context;
  bool loggedIn = false;
  String UID = 'NOT_LOGGED_IN';
  String getUID(){return '<UID>'+UID+'</UID>';}
  String _username;
  Person loggedInPerson;

  String getUsername(){return _username;}

  Connection() {
    if(socket == null){
      setupConnection();
    } else {
      print('Already setup, skipping');
    }
  }

  Future<void> getMyUserData () async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_person');
    socketWriteLine(_username);
    socket.encoding = utf8;
    await for(var data in socket) {
      var dataRaw = utf8.decode(data);
      if(dataRaw == '0'){print('server returns NO');return;}
      Map userMap = jsonDecode(dataRaw);
      print(dataRaw);
      loggedInPerson = Person.fromJson(userMap);
      loggedIn = true;
      print('got user data');
      return;
    }
  }


  void socketWriteLine(String message){
    if(_verbose){
      print('sending:\n'+getUID()+message);
    }
    socket.writeln(getUID()+message);
  }

  void setupConnection() async {
    await loadCert();
    //could add a call to checkconnection() with a small timeout and indicate if the server is online on the login screen
  }
  Future<SecurityContext> loadCert() async{
      var data = await rootBundle.load('assets/etc/new.jks');
      print(data.buffer.asUint8List());
      context = SecurityContext.defaultContext;
      context.setTrustedCertificatesBytes(
          data.buffer.asUint8List(), password: 'fitnessapp');
      cert_loaded = true;
      print('Done parsing cert');
    return context;
  }
  Future<bool> loginUser(String user, String pass) async {
    try{
      socket = await SecureSocket.connect(_address, _port, context: context, timeout: Duration(seconds: 15));
      socketWriteLine('login');
      socketWriteLine(user+'#NEXT#'+pass);
      print(user + ' ' + pass);
      await for(var data in socket){
        var dataFromSocket = String.fromCharCodes(data).trim();
        if(dataFromSocket == '0'){
          print('Could not login with the supplied crendentials');
          return false;
        } else if (dataFromSocket.contains('UID:')) { //if this is in the message we have the right credentials
          UID = dataFromSocket.split('UID:')[1];
          _username = user;
          print('Logged in, i have uid: ' + UID);
          await getMyUserData();
          socket.destroy();
          return true;
        }
        server_online = true;
        return false;
      }
    } on SocketException {
      return false;
    }
  }
  Future<void> logout () async {
    print('hello');
    try{
      if(loggedIn){
        print('Logging out');
        socket = await SecureSocket.connect(_address, _port, context: context);
        socketWriteLine('logout');
        socketWriteLine(getUID());
      }
    } on Exception catch (e){
      print('error logging out. Forcing');
    } finally {
      loggedIn = false;
      socket.destroy();
    }
  }
  void checkConnection() async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('ready');
    socket.listen(genericDataHandler);
    socket.destroy();
  }
  void genericDataHandler(data){
    var dataFromSocket = String.fromCharCodes(data).trim();
    print(dataFromSocket);
  }

  void errorHandler (Object error, StackTrace st){
    print('Socket exception');
    print(error);
  }

  void doneHandler(){
    print('Socket done');
    socket.destroy();
    server_online = false;
  }

  Future<bool> register(Person user) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('register_user');
    socketWriteLine(json.encode(user.toJson()));
    var returns = false;
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      if(dataFromSocket == '1'){
        print('register successfull');
        returns = true;
      } else if (dataFromSocket.contains('-1')){
        print ('email already taken');
        returns = false;
      }
      socket.destroy();
      return returns;
    }
    socket.destroy();
    return returns;
  }
  Future<bool> sendFriendRequest(String to) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('send_friend_request');
    socketWriteLine(to);
    var returns = false;
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      if(dataFromSocket == '1'){
        print('Sent friend request');
        returns = true;
      } else if (dataFromSocket.contains('-1')){
        print ('could not send friend request');
        returns = false;
      } else if (dataFromSocket.contains('-2')){
        print('User: ' + to + ' is not found in the databse');
        returns = false;
      }
      socket.destroy();
      return returns;
    }
    socket.destroy();
    return returns;
  }
  Future<bool> acceptFriendRequest(String from) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('accept_friend_request');
    socketWriteLine(from);
    var returns = false;
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      if(dataFromSocket == '1'){
        print('Accepted friendrequest');
        returns = true;
      } else if (dataFromSocket.contains('-1')){
        print ('could not send friend request');
        returns = false;
      } else if (dataFromSocket.contains('-2')){
        print('User: ' + from + ' is not found in the databse');
        returns = false;
      }
      socket.destroy();
      return returns;
    }
    socket.destroy();
    return returns;
  }
  Future<bool> declineFriendRequest(String from) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('decline_friend_request');
    socketWriteLine(from);
    var returns = false;
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      if(dataFromSocket == '1'){
        print('Declined friendrequest');
        returns = true;
      } else if (dataFromSocket.contains('-1')){
        print ('could not decline friend request');
        returns = false;
      } else if (dataFromSocket.contains('-2')){
        print('User: ' + from + ' is not found in the databse');
        returns = false;
      }
      socket.destroy();
      return returns;
    }
    socket.destroy();
    return returns;
  }
  Future<Person> getFriendData(String email) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_friend');
    socketWriteLine(email);
    var lastResponse = '99';
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      if(lastResponse == '1'){
        print(dataFromSocket);
        Map userMap = jsonDecode(dataFromSocket);
        socket.destroy();
        return Future.value(Person.fromJson(userMap));
      }
      if(dataFromSocket != '1'){
        socket.destroy();
        return null;
      }
      lastResponse = dataFromSocket;
    }
  }
  Future<Map<dynamic,dynamic>> searchByEmail(String search) async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('search_by_email');
    socketWriteLine(search);
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      Map userMap = jsonDecode(dataFromSocket);
      print(userMap);
      socket.destroy();
      return userMap;
    }
  }
  Future<Map<dynamic,dynamic>> getTop25ByRank() async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_top_25');
    socketWriteLine('');
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      Map userMap = jsonDecode(dataFromSocket);
      var sortedKeys = userMap.keys.toList(growable:false)
        ..sort((k2, k1) => userMap[k1].compareTo(userMap[k2]));
      var sortedMap = LinkedHashMap
          .fromIterable(sortedKeys, key: (k) => k, value: (k) => userMap[k]);
      print(sortedMap);
      socket.destroy();
      return Future.value(sortedMap);
    }
  }
  Future<List<dynamic>> getChallenges() async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_challenges');
    socketWriteLine('');
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      //print(dataFromSocket);
      List userMap = jsonDecode(dataFromSocket);
      socket.destroy();
      return Future.value(userMap);
    }
  }
  Future<Map<dynamic,dynamic>> getLeaderBoardPosition() async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_leaderboard_position');
    socketWriteLine('');
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      Map userMap = jsonDecode(dataFromSocket);
      print(userMap);
      socket.destroy();
      return userMap;
    }
  }
  Future<Map<dynamic,dynamic>> getCompletedChallenges() async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_completed_stats');
    socketWriteLine('');
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      Map userMap = jsonDecode(dataFromSocket);
      print(userMap);
      socket.destroy();
      return Future.value(userMap);
    }
  }
  Future<Map<dynamic,dynamic>> getWeightHistory() async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('get_weight_history');
    socketWriteLine('');
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      Map userMap = jsonDecode(dataFromSocket);
      print(userMap);
      socket.destroy();
      return Future.value(userMap);
    }
  }
  Future<bool> completeChallenge(String challengeJson) async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('complete_challenge');
    socketWriteLine(challengeJson);
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      print(dataFromSocket);
      socket.destroy();
      return true;
    }
  }
  Future<bool> setHeight(String height) async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('set_height');
    socketWriteLine(height);
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      socket.destroy();
      if(dataFromSocket == '1'){
        print('set new height $height');
        return true;
      } else if (dataFromSocket == '-1'){
        print('Server said: invalid value for height: $height');
        return false;
      } else {
        print('server returns no');
        return false;
      }
    }
  }
  Future<bool> setWeight(String weight) async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine('set_weight');
    socketWriteLine(weight);
    await for(var response in socket){
      var dataFromSocket = String.fromCharCodes(response).trim();
      socket.destroy();
      if(dataFromSocket == '1'){
        print('set new weight $weight');
        return true;
      } else if (dataFromSocket == '-1'){
        print('Server said: invalid value for weight: $weight');
        return false;
      } else {
        print('server returns no');
        return false;
      }
    }
  }
}