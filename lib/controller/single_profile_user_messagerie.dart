import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {

    if(widget.user.messages != null){
      for(String key_1 in widget.user.messages!.keys){
        for(Map<String, dynamic> messageMap in widget.user.messages![key_1]){
          messageMap["ISME"] = 0;
          messages.add(messageMap);
        }
      }
    }

    if(me.messages != null){
      for(String key_1 in me.messages!.keys){
        if(key_1.trim() == widget.user.id){
          for(Map<String, dynamic> messageMap in me.messages![key_1]){
            messageMap["ISME"] = 1;
            messages.add(messageMap);
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
          child: Container(

            color: Colors.white10,
            child: TextField(
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
