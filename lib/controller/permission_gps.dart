import 'package:geolocator/geolocator.dart';

class PermissionGps {
  
  Future<Position> init() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error("La localisation n'est pas activée");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    return await checkPermission(permission);
  }

  Future<Position>checkPermission(LocationPermission location){
    switch(location){
      case LocationPermission.deniedForever : return Future.error("Ne souhaite pas être Géolocalisé");
      case LocationPermission.denied : return Geolocator.requestPermission().then((value) => checkPermission(value));
      case LocationPermission.unableToDetermine : return Geolocator.requestPermission().then((value) => checkPermission(value));
      case LocationPermission.whileInUse : return Geolocator.getCurrentPosition();
      case LocationPermission.always : return Geolocator.getCurrentPosition();
    }

  }
 

  
}