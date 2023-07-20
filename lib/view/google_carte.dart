import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ipssisqy2023/model/my_user.dart';

import '../controller/firestore_helper.dart';
import '../controller/single_profile_user_page.dart';
import '../globale.dart';

class GoogleCarte extends StatefulWidget {

  Position location;
  GoogleCarte({super.key, required this.location});

  @override
  State<GoogleCarte> createState() => _GoogleCarteState();
}

class _GoogleCarteState extends State<GoogleCarte> {

  Completer<GoogleMapController> completer = Completer();
  late CameraPosition camera;

  @override
  void initState() {

    camera = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 10
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
/*
    List<Marker> markers = [];

    // Coordonnée proche d'Auneau
    double Lat = Random().nextDouble() + 48;
    double Lng = Random().nextDouble() + 1;
    for(int i = 0; i <= users.length; i++){
      markers.add(
        Marker(
          markerId: MarkerId(me.fullName),
          position: LatLng(Lat, Lng),
          onTap: () async {
            return await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context){
              TextEditingController text = TextEditingController();
              return AlertDialog(
                title: Text(me.fullName),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      TextField(
                      controller: text,
                      decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ecrivez votre message'
                      ),
                      ),
                      TextButton(onPressed: (){
                      setState(() {
                      // TODO envoyer en base de données le message
                      text.text = "";
                      });
                      }, child: Text("Envoyez"))
                    ],
                  ),
                ),

                );
              }
            );
            }
        )
      );
    }
*/
    /*Marker marker = Marker(
        markerId: MarkerId(me.fullName),
        position: LatLng(Lat, Lng),
        onTap: () async {
          return await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context){
                TextEditingController text = TextEditingController();
                return AlertDialog(
                  title: Text(me.fullName),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        TextField(
                          controller: text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Ecrivez votre message'
                          ),
                        ),
                        TextButton(onPressed: (){
                          setState(() {
                            // TODO envoyer en base de données le message
                            text.text = "";
                          });
                        }, child: Text("Envoyez"))
                      ],
                    ),
                  ),

                );
              }
          );
        }
    );*/




  return StreamBuilder<QuerySnapshot>(
    stream: FirestoreHelper().cloudUsers.snapshots(),
    builder: (context, snap) {
      var _markers = <Marker>{};
      List documents = snap.data?.docs ?? [];
      for(var data in documents){
        MyUser user = MyUser(data);
        double lat = Random().nextDouble() + 48;
        double lng = Random().nextDouble() + 1;
        _markers.add(
          Marker(
              markerId: MarkerId(user.fullName),
              position: LatLng(lat, lng),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                    builder : (context){
                      return SingleProfileUserPage(user, 1);
                    }
                ));
              }
          )
        );
      }

      return GoogleMap(
        initialCameraPosition: camera,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (control) async {
          String style = await DefaultAssetBundle.of(context).loadString("lib/map_style.json");
          control.setMapStyle(style);
          completer.complete(control);
        },
        markers: _markers,
      );
    }
  );



    /*return GoogleMap(
      initialCameraPosition: camera,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onMapCreated: (control) async {
        String style = await DefaultAssetBundle.of(context).loadString("lib/map_style.json");
        control.setMapStyle(style);
        completer.complete(control);
      },
      markers: {
        marker
      },
    );*/
  }
}
