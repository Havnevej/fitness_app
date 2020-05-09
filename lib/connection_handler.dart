import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_fitness_app/person.dart';

class Connection {
  SecureSocket socket;
  int _port = 9001;
  String _address = "192.168.8.102";
  bool server_online = false;
  bool cert_loaded = false;
  bool _verbose = false;
  SecurityContext context;
  bool loggedIn = false;
  String UID = "NOT_LOGGED_IN";
  String getUID(){return "<UID>"+UID+"</UID>";}
  String _username = 'ch@ruc.dk';
  Person loggedInPerson;

  String getUsername(){return _username;}

  Connection() {
    if(socket == null){
      setupConnection();
    } else {
      print("Already setup, skipping");
    }
  }

  Future<void> getMyUserData () async{
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine("get_person");
    socketWriteLine(_username);
    socket.encoding = utf8;
    await for(var data in socket) {
      String dataRaw = utf8.decode(data);
      if(dataRaw == "0"){print("server returns NO");return;}
      Map userMap = jsonDecode(dataRaw);
      print(dataRaw);
      loggedInPerson = Person.fromJson(userMap);
      loggedIn = true;
      print("got user data");
      return;
    }
  }


  void socketWriteLine(String message){
    if(_verbose){
      print("sending:\n"+getUID()+message);
    }
    socket.writeln(getUID()+message);
  }

  void setupConnection() async {
    await loadCert().then((s){
      checkConnection();
    });
  }
  Future<SecurityContext> loadCert() async{
      ByteData data = await rootBundle.load('assets/etc/new.jks');
      print(data.buffer.asUint8List());
      this.context = SecurityContext.defaultContext;
      this.context.setTrustedCertificatesBytes(
          data.buffer.asUint8List(), password: "fitnessapp");
      this.cert_loaded = true;
      print("Done parsing cert");
    return this.context;
  }

  Future<bool> loginUser(String user, String pass) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine("login");
    socketWriteLine(user+"#NEXT#"+pass);
    print(user + " " + pass);
    await for(var data in socket){
      String dataFromSocket = new String.fromCharCodes(data).trim();
      if(dataFromSocket == "0"){
        print("Could not login with the supplied crendentials");
        return false;
      } else if (dataFromSocket.contains("UID:")) { //if this is in the message we have the right credentials
        UID = dataFromSocket.split("UID:")[1];
        _username = user;
        print("Logged in, i have uid: " + UID);
        await getMyUserData();
        socket.destroy();
        return true;
      }
      server_online = true;
      return false;
    }
  }

  Future<void> logout () async {
    print('hello');
    try{
      if(loggedIn){
        print('Logging out');
        socket = await SecureSocket.connect(_address, _port, context: context);
        socketWriteLine("logout");
        socketWriteLine(getUID());
      }
    } on Exception catch (e){
      print("error logging out. Forcing");
    } finally {
      loggedIn = false;
      socket.destroy();
    }
  }
  void checkConnection() async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine("ready");
    socket.listen(genericDataHandler);
    socket.destroy();
  }
  void genericDataHandler(data){
    String dataFromSocket = new String.fromCharCodes(data).trim();
    print(dataFromSocket);
  }

  void errorHandler (Object error, StackTrace st){
    print("Socket exception");
    print(error);
  }

  void doneHandler(){
    print("Socket done");
    socket.destroy();
    server_online = false;
  }

  Future<bool> register(Person user) async {
    socket = await SecureSocket.connect(_address, _port, context: context);
    socketWriteLine("register_user");
    socketWriteLine(json.encode(user.toJson()));
    bool returns = false;
    await for(var response in socket){
      String dataFromSocket = new String.fromCharCodes(response).trim();
      if(dataFromSocket == "1"){
        print("register successfull");
        returns = true;
      } else if (dataFromSocket.contains("-1")){
        print ("email already taken");
        returns = false;
      }
    }
    socket.destroy();
    return returns;
  }
}