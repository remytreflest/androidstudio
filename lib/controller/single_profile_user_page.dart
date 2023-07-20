import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/single_profile_user_messagerie.dart';
import 'package:ipssisqy2023/controller/single_user_profile.dart';

import '../model/my_user.dart';

class SingleProfileUserPage extends StatefulWidget {
  MyUser user;
  int optionalIndex = 0;
  SingleProfileUserPage(this.user, this.optionalIndex, {super.key});


  @override
  State<SingleProfileUserPage> createState() => _SingleProfileUserPageState();
}

class _SingleProfileUserPageState extends State<SingleProfileUserPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    setState(() {
      currentIndex = widget.optionalIndex == 0 ? currentIndex : widget.optionalIndex;
    });

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.user.fullName),
          backgroundColor: Colors.purple,
          centerTitle : true
      ),
      body: bodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.optionalIndex == 0 ? currentIndex : widget.optionalIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Messagerie"
          ),
        ],
      ),
    );
  }

  Widget bodyPage(){
    switch(currentIndex){
      case 0: return SingleUserProfile(widget.user);
      case 1: return SingleProfileUserMessagerie(widget.user);
      default: return const Text("Problème d'affichage");
    }
  }
}
