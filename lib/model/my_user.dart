

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


  //
  myUser(){
    id = "";
    mail = "";
    nom = "";
    prenom = "";
  }


}