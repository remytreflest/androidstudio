import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/animation_controller.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';
import 'package:ipssisqy2023/view/dashboard_view.dart';

class MyRegisterView extends StatefulWidget {
  const MyRegisterView({super.key});

  @override
  State<MyRegisterView> createState() => _MyRegisterViewState();
}

class _MyRegisterViewState extends State<MyRegisterView> {
  //variable
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Ma première application"),
            backgroundColor: Colors.purple,
            centerTitle : true
        ),
        body:  SingleChildScrollView(

            child : Padding(
                padding : const EdgeInsets.all(10),
                child : Center(

                    child :   Column(
                        mainAxisAlignment : MainAxisAlignment.center,
                        children : [
                          //image
                          MyAnimationController(
                            delay: 1,
                            child: Container(
                                height : 250,
                                width : 350,
                                decoration : BoxDecoration(

                                    borderRadius : BorderRadius.circular(15),
                                    image : const DecorationImage(

                                        image :NetworkImage("https://tse1.mm.bing.net/th?id=OIP.zRmpjD_EOxCboGENHfjxHAHaEc&pid=Api"),
                                        fit : BoxFit.fill
                                    )

                                )

                            ),
                          ),
                          const SizedBox(height : 15),

                          //adresse mail
                          MyAnimationController(
                            delay: 2,
                            child: TextField(
                              controller: mail,
                                decoration : InputDecoration(
                                    hintText: "Entrer votre adresse mail",
                                    prefixIcon : const Icon(Icons.person),
                                    border : OutlineInputBorder(
                                      borderRadius : BorderRadius.circular(15),

                                    )

                                )

                            ),
                          ),


                          //mot de passe

                          const SizedBox(height : 15),


                          MyAnimationController(
                            delay: 3,
                            child: TextField(
                              controller : password,
                              obscureText : true,
                              decoration : InputDecoration(
                                  hintText: "Entrer votre mot de passe",
                                  prefixIcon : const Icon(Icons.lock),

                                  border : OutlineInputBorder(
                                    borderRadius : BorderRadius.circular(15),

                                  )

                              ),

                            ),
                          ),

                          const SizedBox(height : 15),

                          MyAnimationController(
                            delay: 4,
                            child: ElevatedButton(
                                style : ElevatedButton.styleFrom(
                                    backgroundColor : Colors.purple,
                                    shape : const StadiumBorder()
                                ),

                                onPressed : (){
                                  Navigator.push(context,MaterialPageRoute(
                                      builder : (context){
                                        return const MyDashBoardView();
                                      }

                                  ));
                                },

                                child : const Text("Connexion")
                            ),
                          ),

                          MyAnimationController(
                              delay: 6,
                              child: TextButton(
                                onPressed: (){
                                  FirestoreHelper().register(mail.text, password.text);
                                },
                                child: const Text("Inscription"),
                              )
                          )

                          //bouton
                        ]
                    )

                )



            )
        )
    );
  }
}
