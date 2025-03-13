import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/model/bloco_location.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class HomeViewModel extends ChangeNotifier{

BlocoServiceImpl blocoServiceImpl = BlocoServiceImpl();

List<Bloco> _blocoList = [];
List<Bloco> get blocoList => _blocoList;
String city = ""; 
double latitude = 0.0;
double longitude = 0.0;

List<Bloco> blocosProximos = [];



Future<List<Bloco>> fetchAllBlocos() async{
   try{
    
   _blocoList = await blocoServiceImpl.getAllBloco();
    notifyListeners();
    }catch (e){
      print('Erro ao buscar contatos: $e ');
   
    }

    return _blocoList;
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
   
    notifyListeners();
    
    print(currentPosition);

    
  }




Future<List<BlocoLocation>> getLatLongFromAddress(List<Bloco> latLongBlockList) async {

    List<Location> locations = [];	
    List<BlocoLocation> blocoLocationList = [];	
  try {
    for (var element in latLongBlockList) {
      // Await the asynchronous operation
      locations = await locationFromAddress(element.address);

      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        print('Latitude: $latitude, Longitude: $longitude');

        // Add the result to the list
        blocoLocationList.add(BlocoLocation(latitude, longitude, element.title));
      } else {
        print('Endereço não encontrado!');
      }
      
    }

    // Return the fully populated list after the loop
    return blocoLocationList;
  } catch (e) {
    print('Error: $e');
    return []; // Return an empty list in case of an error
  }

}


Future<String> getAddressFromLatLong(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {

      Placemark place = placemarks.first;
      city =  "${place.subAdministrativeArea}";
      notifyListeners();
    } else {
      print("Nenhum endereço encontrado!");
    }
  } catch (e) {
    print("Erro ao obter endereço: $e");
  }
    return city;
}

Future<List<Bloco>> getNearestCarnivalBlock() async {
  if(city.isNotEmpty){
  blocosProximos = await blocoServiceImpl.getBlocosByCity(city);
  notifyListeners();
  }

   return blocosProximos;
}



}