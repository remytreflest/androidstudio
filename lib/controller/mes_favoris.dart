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

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 15;
    final double itemWidth = size.width / 2;

    return GridView.builder(
        itemCount: maListeAmis.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context,index){
          MyUser otherUser = maListeAmis[index];
          return Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(
                          builder : (context){
                            return SingleProfileUserPage(otherUser, 0);
                          }
                        ));
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.person, size: 50),
                          Text(otherUser.fullName),
                        ],
                      )
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}