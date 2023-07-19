import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';

import '../globale.dart';
import '../model/my_user.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().cloudUsers.snapshots(),
      builder: (context, snap){
        List documents = snap.data?.docs ?? [];
        if(documents.isEmpty){
          return Center(
            child: Text("Pas de données"),
          );
        } else {
          return ListView.builder(
            itemCount: documents.length,
              itemBuilder: (context, index){
              MyUser autreUtilisateur = MyUser(documents[index]);
              if(me.id == autreUtilisateur.id){
                return Container();
              } else {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.amberAccent,
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(autreUtilisateur.avatar ?? defaultImage),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    title: Text(autreUtilisateur.fullName),
                    subtitle: Text(autreUtilisateur.mail ?? ""),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: (me.favoris!.contains(autreUtilisateur.id) ? Colors.red : Colors.greenAccent)),
                      onPressed: (){
                        if(me.favoris.contains(autreUtilisateur.id)){
                          me.favoris.remove(autreUtilisateur.id);
                        } else {
                          me.favoris.add(autreUtilisateur.id);
                        }
                        Map<String, dynamic> map = {
                          "FAVORIS": me.favoris
                        };
                        FirestoreHelper().updateUser(me.id, map);
                      },
                    ),
                  ),
                );
              }
            }
          );
        }
      }
    );
  }
}
