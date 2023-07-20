import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';

import '../globale.dart';
import '../model/my_user.dart';

class SingleProfileUserMessagerie extends StatefulWidget {
  MyUser user;
  SingleProfileUserMessagerie(this.user, {super.key});

  @override
  State<SingleProfileUserMessagerie> createState() => _SingleProfileUserMessagerieState();
}

class _SingleProfileUserMessagerieState extends State<SingleProfileUserMessagerie> {

  TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> myMessages = [];
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {

    if(widget.user.messages != null){
      for(String key_1 in widget.user.messages!.keys){
        for(Map<String, dynamic> messageMap in widget.user.messages![key_1]!){
          messageMap["ISME"] = 0;
          messages.add(messageMap);
        }
      }
    }

    if(me.messages != null){
      for(String key_1 in me.messages!.keys){
        print("key_1 : " + key_1.toString());
        print("widget.user.id : " + widget.user.id);
        if(key_1.trim() == widget.user.id){
          for(Map<String, dynamic> messageMap in me.messages![key_1]!){
            messageMap["ISME"] = 1;
            messages.add(messageMap);
            myMessages.add(messageMap);
          }
        }
      }
    }

    if(messages.length > 0){
      messages.sort((a, b){ //sorting in ascending order
        return DateTime.parse(a["DATE"].toDate().toString()).compareTo(DateTime.parse(b["DATE"].toDate().toString()));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              // TODO controller pour voir le dernier message lorsqu'un message ets ajouté
              itemCount: messages.length,
              itemBuilder: (context,index){
                Map<String, dynamic> message = messages[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: (message["ISME"] == 1 ? Colors.amberAccent : Colors.greenAccent),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        ListTile( title: Text('${DateTime.parse(message["DATE"].toDate().toString())}')),
                        ListTile(title: Text(message["MESSAGE"])),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),

        Flexible(
          child: Column(
            children: [
              TextField(
                  controller: messageController,
                  maxLines: null,
                  decoration : InputDecoration(
                      hintText: "Entrer votre message",
                      prefixIcon : const Icon(Icons.person),
                      border : OutlineInputBorder(
                        borderRadius : BorderRadius.circular(15),
                      )
                  )
              ),
              TextButton(onPressed: () {
                // INSERTION EN BDD
                if(messageController.text.isNotEmpty){

                  if(me.messages.isEmpty || me.messages[widget.user.id] == null){
                    setState(() {
                      me.messages[widget.user.id] = [
                        {
                          "DATE" : Timestamp.fromDate(DateTime.now()),
                          "MESSAGE" : messageController.text
                        }
                      ];
                    });

                    return;
                  }

                  setState(() {
                    me.messages![widget.user.id]!.add({
                      "DATE" : Timestamp.fromDate(DateTime.now()),
                      "MESSAGE" : messageController.text
                    });
                    messages.add({
                      "DATE" : Timestamp.fromDate(DateTime.now()),
                      "MESSAGE" : messageController.text,
                      "ISME" : 1
                    });
                  });

                  Map<String, Map<String, List<Map<String,dynamic>>>> toUpdate = {
                    "MESSAGES" : me.messages
                  };
                  print("JACQUES");
                  FirestoreHelper().updateUser(me.id, toUpdate);
                  messageController.text = "";
                }


              }, child: Text("Envoyer Message"))
            ],
          ),
        )
      ],
    );
    return GridView.builder(
        itemCount: messages.length,
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemBuilder: (context,index){
          Map<String, dynamic> message = messages[index];
          print(message.toString());
          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: Column(
                children: [
                  ListTile( title: Text('${DateTime.parse(message["DATE"].toDate().toString())}')),
                  ListTile(title: Text(message["MESSAGE"])),
                ],
              ),
            ),
          );
        }
    );
  }
}
