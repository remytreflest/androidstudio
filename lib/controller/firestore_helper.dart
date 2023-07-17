//classe qui va nou aider à la gestion de la base de donnée

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper{
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");


  //inscription
  register(String email , String password){
    auth.createUserWithEmailAndPassword(email: email, password: password);

  }



  //connexion







}