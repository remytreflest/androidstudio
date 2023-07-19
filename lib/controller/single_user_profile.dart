import 'package:flutter/material.dart';

import '../globale.dart';
import '../model/my_user.dart';

class SingleUserProfile extends StatefulWidget {
  MyUser user;
  SingleUserProfile(this.user, {super.key});

  @override
  State<SingleUserProfile> createState() => _SingleUserProfileState();
}

class _SingleUserProfileState extends State<SingleUserProfile> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height : 5),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(widget.user.avatar ?? defaultImage),
                        fit: BoxFit.contain
                    )
                ),
              ),

              const SizedBox(height : 5),
              const Divider(
                thickness: 3,
                color: Colors.black12,
              ),
              ListTile(
                leading: const  Icon(Icons.person,color: Colors.purple,),
                title: Text(widget.user.fullName,style: const TextStyle(fontSize: 20)),
                subtitle: Text((widget.user.pseudo!.isEmpty ? "Aucun pseudo" : widget.user.pseudo!), style: const TextStyle(fontSize: 20, color: Colors.black54)),
              ),
              ListTile(
                leading: const  Icon(Icons.mail,color: Colors.purple,),
                title: Text(widget.user.mail,style: const TextStyle(fontSize: 20),),
              ),
              ListTile(
                leading: const  Icon(Icons.cake,color: Colors.purple,),
                title: Text("${widget.user.birthday!.year}-${widget.user.birthday!.month}-${widget.user.birthday!.day}",style: const TextStyle(fontSize: 20),),
              ),
              ListTile(
                leading: const  Icon(Icons.gesture,color: Colors.purple,),
                title: Text("Genre : ${widget.user.genre.toString().split('.').last}",style: const TextStyle(fontSize: 20),),
              ),
              ListTile(
                leading: const  Icon(Icons.favorite,color: Colors.red,),
                title: Text("Nombre de favoris : ${widget.user.favoris.length}",style: const TextStyle(fontSize: 20),),
              ),
            ].map((widget) => Padding(
              padding: const EdgeInsets.all(10),
              child: widget,
            )).toList(),
          ),
        )
    );
  }
}
