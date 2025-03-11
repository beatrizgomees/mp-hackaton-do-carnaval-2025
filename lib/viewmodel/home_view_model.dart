import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class HomeViewModel extends ChangeNotifier{

BlocoServiceImpl blocoServiceImpl = BlocoServiceImpl();

List<Bloco> _blocoList = [];
String address = ""; 

List<Bloco> nearbyBlocos = [];


initState(){


}


Future<List<Bloco>> fetchAllBlocos() async{
   try{
    
   _blocoList = await blocoServiceImpl.getAllBloco();
    notifyListeners();
    getBlocoProxUser(address);
    return _blocoList;
    }catch (e){
      print('Erro ao buscar contatos: $e ');
      return _blocoList;
    }



}


 Future<void> getCurrentLocation(LatLng? currentPosition, MapController mapController) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return;
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return;
      }
    }

     if (permission == LocationPermission.deniedForever) {
      return;
    }
    // Obtém a localização atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );


    
    currentPosition = LatLng(position.latitude, position.longitude);
   
    getAddressFromLatLong(currentPosition.latitude, currentPosition.longitude);
    notifyListeners();
    
    print(currentPosition);

    
  }




// Future<void> getLatLongFromAddress(String address) async {
//   try {
//     List<Location> locations = await locationFromAddress(address);

//     if (locations.isNotEmpty) {
//       double latitude = locations.first.latitude;
//       double longitude = locations.first.longitude;

//       print('Latitude: $latitude, Longitude: $longitude');
//     } else {
//       print('Endereço não encontrado!');
//     }
//   } catch (e) {
//     print('Erro ao converter endereço: $e');
//   }
// }




Future<String> getAddressFromLatLong(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {

      Placemark place = placemarks.first;
      address =  "${place.subAdministrativeArea}";
      getBlocoProxUser(address);
     
      
    } else {
      print("Nenhum endereço encontrado!");
    }
  } catch (e) {
    print("Erro ao obter endereço: $e");
  }
    return address;
}

List<Bloco> getBlocoProxUser(String  address){
  _blocoList.forEach((element) {
    if(element.city == address){
      nearbyBlocos.add(element);
    }
    },
  );
  return nearbyBlocos;
}



}