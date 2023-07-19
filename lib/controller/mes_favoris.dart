import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';
import 'package:ipssisqy2023/controller/single_profile_user_page.dart';
import 'package:ipssisqy2023/controller/single_user_profile.dart';
import 'package:ipssisqy2023/globale.dart';
import 'package:ipssisqy2023/model/my_user.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  List<MyUser> maListeAmis = [];

  @override
  void initState() {
    // TODO: implement initState
    for(String uid in me.favoris!){
      FirestoreHelper().getUser(uid).then((value){
        setState(() {
          maListeAmis.add(value);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: maListeAmis.length,
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemBuilder: (context,index){
          MyUser otherUser = maListeAmis[index];
          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // radius: MediaQuery.of(context).size.height * 0.025,
                    radius: 40,
                    backgroundImage: NetworkImage(otherUser.avatar ?? defaultImage),
                  ),
                  const SizedBox(height : 10),
                  Text(otherUser.fullName),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(
                          builder : (context){
                            return SingleProfileUserPage(otherUser);
                          }
                        ));
                      },
                      child: const Icon(Icons.person, size: 50)
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}