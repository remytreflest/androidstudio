import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  TextEditingController messageController = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Map<String, dynamic>> myMessages = [];
  List<Map<String, dynamic>> messages = [];

  // function
  // PROBLEME : lors de l'ajout d'un élément, lorsque celui ci passe "sous" le textfield, la taille totale de la
  // listview est mal calculée et on scroll donc que jusq'à l'avant dernier élément.
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

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
    // Permet de scroller en bas de la conversation après le chargement initial des données
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollDown());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: 6,
              bottom: 6
            ),
            controller: _controller,
              itemCount: messages.length,
              itemBuilder: (context,index){
                Map<String, dynamic> message = messages[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(
                      left: message["ISME"] != 1 ? 6 : MediaQuery.of(context).size.width / 4,
                      right: message["ISME"] == 1 ? 6 : MediaQuery.of(context).size.width / 4,
                      top: 3,
                      bottom: 3),
                  decoration: BoxDecoration(
                      color: (message["ISME"] == 1 ? Colors.amberAccent : Colors.greenAccent),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only( bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                              child: Text(df.format(DateTime.parse(message["DATE"].toDate().toString())))
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                            child: Text(message["MESSAGE"])
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),

        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
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
                    } else {

                      setState(() {
                        me.messages![widget.user.id]!.add({
                          "DATE" : Timestamp.fromDate(DateTime.now()),
                          "MESSAGE" : messageController.text
                        });
                      });

                    }

                    Map<String, Map<String, List<Map<String,dynamic>>>> toUpdate = {
                      "MESSAGES" : me.messages
                    };
                    FirestoreHelper().updateUser(me.id, toUpdate);

                    setState(() {
                      messages.add({
                        "DATE" : Timestamp.fromDate(DateTime.now()),
                        "MESSAGE" : messageController.text,
                        "ISME" : 1
                      });
                      messageController.text = "";
                      _scrollDown();
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  }

                }, child: Text("Envoyer Message"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
