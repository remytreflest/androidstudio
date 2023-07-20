

import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipssisqy2023/globale.dart';

class MyUser {
  late String id;
  late String mail;
  late String nom;
  late String prenom;
  String? pseudo;
  DateTime? birthday;
  String? avatar;
  Gender genre = Gender.indefini;
  List favoris = [];
  late Map<String, List<Map<String,dynamic>>> messages;



  String get fullName {
    return prenom + " "+ nom;
  }


  //
  MyUser.empty(){
    id = "";
    mail = "";
    nom = "";
    prenom = "";
    messages = {};
  }

  MyUser(DocumentSnapshot snapshot){
    id = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    mail = map["EMAIL"];
    nom = map["NOM"];
    prenom = map["PRENOM"];
    String? provisoirePseudo =  map["PSEUDO"];
    favoris = map["FAVORIS"] ?? [];
    if(provisoirePseudo == null){
      pseudo = "";
    }
    else
    {
      pseudo = provisoirePseudo;
    }
    Timestamp? birthdayProvisoire = map["BIRTHDAY"];
    birthday = map["BIRTHDAY"] == null ? DateTime.now() : (map["BIRTHDAY"] as Timestamp).toDate();
    avatar = map["AVATAR"] ?? defaultImage;
    /*("JOSHUA");
    for(var key in map["MESSAGES"].keys){
      print("KEY " + key.toString());
    }
    print(map["MESSAGES"].toString());*/
    messages = map["MESSAGES"] != null ? parseJsonMessagesData(map["MESSAGES"]) : {};
  }

  Map<String, List<Map<String,dynamic>>> parseJsonMessagesData(var data){

    Map<String, List<Map<String,dynamic>>> result = <String, List<Map<String,dynamic>>>{};

    for(var key in data.keys){
      List<Map<String, dynamic>> userConversation = [];
      for(int i = 0; i < data[key].length; i++){
        userConversation.add({
          "DATE" : data[key][i]["DATE"],
          "MESSAGE" : data[key][i]["MESSAGE"]
        });
      }
      result[key] = userConversation;
    }
    return result;
  }

}